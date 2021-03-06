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
        array_of_jobs = []
        parsed_json.each do |posting|
            hash = {}
            hash[:title] = posting["title"]
            hash[:company] = posting["company"]
            hash[:description] = Sanitize.fragment(posting["description"])
            hash[:githubjobs_url] = posting["url"]

            array_of_jobs << Job.new(hash)
        end
        
        array_of_jobs
    end

    # entries should be either a hash or an array of hashes which contain the job postings the user wants to save
    def self.save_jobs(jobs:, user:)
        # we want to pull close to all the data from the :githubjobs_url link
        jobs.each do |job|
            job_posting = JSON.parse(open("#{job.githubjobs_url}.json").read)
            



            '''
            hash = {}

            
            hash[:title] = job_posting["title"]
            hash[:type] = job_posting["type"]
            hash[:company] = job_posting["company"]
            hash[:githubjobs_url] = job_posting["githubjobs_url"]

            '''

            
            job.company_url = job_posting["company_url"]
            job.created_at = job_posting["created_at"]
            job.location = job_posting["location"]
            job.description = Sanitize.fragment(job_posting["description"])
            job.how_to_apply = Sanitize.fragment(job_posting["how_to_apply"])

            user.save_job( job )
            
        end
    end
end