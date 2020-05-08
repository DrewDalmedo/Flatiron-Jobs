class JobFinderController
    def call
        start
    end

    '''
    parser
    job

    greeting
    zipcode
    parser
    return results
    array_of_results = Parser.fetch_jobs(location)
    pick a job to save 
    hash_of_picked_job = array_of_results[number they picked here as the index minus 1]
    Job.new(hash_of_picked_job)
    '''
    def start
        puts "Welcome to Flatiron Jobs!"
        puts "========================="
        temp_user = User.new()
        search_for_jobs(temp_user)


    end


    def search_for_jobs(user)
        puts "Please enter your preferred job title, benefits, companies, or expertise:"
        user.wants_type_of_job = gets.strip
        puts "-------------------------"
        puts "Great! Now, please enter the zipcode or name of the area you'd like to search in:"
        user.location = gets.strip
        puts "-------------------------"
        puts "Would you like to restrict your search to full time jobs? (yes/no)"
        user.wants_fulltime = gets.strip
        if user.wants_fulltime == "yes"
            user.wants_fulltime = "on"
        elsif user.wants_fulltime == "no"
            user.wants_fulltime = "off"
        else
            puts "ERROR: not a valid answer!!! defaulting to no..."
        end
        puts "-------------------------"
        puts "Processing your job search..."
        results = Parser.get_results(description: user.wants_type_of_job, location: user.location, full_time: user.wants_fulltime)
        #ap results
        puts "Done!"
        puts "-------------------------"
        if !(results.size == 0)
            results.each do |result| 
                puts "#{results.index(result)+1}. #{result[:title]} : #{result[:company]}"
            end
        end
        puts "-------------------------"
        puts "Please enter the number of the job you want to know more about:"
        user_input = gets.strip.to_i
        puts "-------------------------"
        if (user_input < 1 || user_input > results.size)
            puts "not a valid number!"
        else
            puts "#{results[user_input-1][:title]} : #{results[user_input-1][:company]}\n\n"
            puts results[user_input-1][:description]
        end
        puts "-------------------------"
        #puts results[user_input-1][:githubjobs_url]
        #ap Job.new(results[user_input-1])
        puts "Select which jobs to save"
        saving = gets.strip
        saving = saving.split(" ")
        saved_jobs_array = []

        index = 0
        while index < saving.size
            #saved_jobs_array << results[saving[index].to_i-1]
            user.save_job( Job.new(results[saving[index].to_i-1].githubjobs_url) )
            index += 1
        end

        #Parser.save_entries(entries: saved_jobs_array, user: user)
        ap user.saved_jobs
    end
end