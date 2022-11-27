#!/usr/bin/ruby

require 'net/http'
require 'JSON'

CREATES_IO_BASE_URI = "https://crates.io/api/v1"
REPO = "https://github.com/belltoy/search.rust.crates.alfredworkflow"
USER_AGENT = "Alfred Workflow (#{REPO})"

def query_crates_io(query)
    uri = URI(CREATES_IO_BASE_URI + "/crates?per_page=10&sort=downloads&q=#{query}")
    req = Net::HTTP::Get.new(uri)
    req['User-Agent'] = USER_AGENT
    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
    end

    if res.is_a?(Net::HTTPSuccess)
        begin
            JSON.parse(res.body)
        rescue JSON::ParserError => e
            warn e.message
            return []
        end
    else
        warn "Failed to download crates list from crates.io"
        return []
    end
end

def format_results(results)
    crates = results["crates"]

    crates.map { |r|
        name       = r["name"]
        dep = dep_text(name, r)

        doc_url    = r["documentation"] || "https://docs.rs/#{name}"
        repo_url = r["repository"] || doc_url
        home_url = r["homepage"] || doc_url
        crates_url = "https://crates.io/crates/#{r["id"]}"

        {
            title: name,
            subtitle: r["description"],
            arg: doc_url,
            variables: {
                max_stable_version: r["max_stable_version"],
                max_version: r["max_version"],
                newest_version: r["newest_version"],
                updated_at: r["updated_at"],
                dep: dep
            },
            text: {
                copy: dep,
                largetype: dep,
            },
            mods: {
                alt: {
                    subtitle: "Open Homepage (#{home_url})",
                    arg: home_url
                },
                cmd: {
                    subtitle: "Open Repository (#{repo_url})",
                    arg: repo_url
                },
                ctrl: {
                    subtitle: "Open crates.io (#{crates_url})",
                    arg: crates_url
                }
            }
        }
    }
end

def dep_text(name, res)
    v = res["max_stable_version"]
    return %Q[#{name} = "#{v}"]
end

def format_for_alfred(results)
    JSON.generate({items: results})
end

query = ARGV[0]
puts format_for_alfred(format_results(query_crates_io(query)))
