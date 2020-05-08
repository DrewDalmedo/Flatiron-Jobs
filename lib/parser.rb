'''
create many job and employer instances from json

def get_results(location)
    make the request to githubjobs with location in url 
    store the results into avairable
    array_hash = []
    results.each do |result|
        hash = {}
        hash[:title] = result.title 
        array_hash << hash 
    end
    iterate over each varialbe, grab the data necessary, and prepare a hash of that information that ultimately gets passed into an array
    array_hash 
end
'''


class Parser
    GITHUB_JOBS_API_LINK = "https://jobs.github.com/positions.json?utf8=%E2%9C%93"
    SEPARATOR = "&"

    def self.get_results(description: "", location: "", full_time: "off")
        url = open(GITHUB_JOBS_API_LINK + SEPARATOR + "description=#{description}" + SEPARATOR + "location=#{location}" + SEPARATOR + "full_time=#{full_time}")
        parsed_json = JSON.parse(url.read)

        # grabbing the most relevant info for preview
        array_hash = []
        parsed_json.each do |posting|
            hash = {}
            hash[:title] = posting["title"]
            hash[:type] = posting["type"]
            hash[:company] = posting["company"]
            #hash[:company_url] = posting["company_url"]
            #hash[:created_at] = posting["created_at"]
            hash[:githubjobs_url] = posting["url"]
            hash[:description] = Sanitize.fragment(posting["description"])
            #hash[:how_to_apply] = Sanitize.fragment(posting["how_to_apply"])
            array_hash << hash
        end
        
        array_hash
    end

    # entries should be either a hash or an array of hashes which contain the job postings the user wants to save
    def self.save_entries(entries:, user:)
        GITHUB_POSITION_LINK = "https://jobs.github.com/positions/"
        # we want to pull close to all the data from the :githubjobs_url link
        entries.each do |entry|
            temp_hash = {}
            parsed_json = JSON.parse(open("#{entry[:githubjobs_url]}.json").read)

            
            #user.saved_jobs << Job.new(entry)
        end
    end
end