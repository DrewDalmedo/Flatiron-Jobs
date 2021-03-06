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
        puts "Welcome to #{"// Flatiron".blue} Jobs!"
        puts "========================="
        main_menu
    end

    def main_menu
        temp_user = User.new()
        
        puts "Please select one of the following options by number:"
        exit_flag = false
        while(exit_flag == false)
            puts "0. Exit program"
            puts "1. Search for jobs"
            puts "2. List saved jobs"
            puts "-------------------------"
            user_input = gets.strip.to_i
            puts "-------------------------"
            if (user_input == 0)
                exit_flag = true
                puts "#{"//".blue} #{"See you next time!".green}"
            elsif (user_input == 1)
                search_for_jobs(temp_user)
            elsif (user_input == 2)
                temp_user.print_jobs
            else
                puts "Not a valid option!"
            end
            puts "-------------------------"

        end
        
    end

    def preview_jobs(results)
        exit_flag = false
        while !(exit_flag)
            if !(results.size == 0)
                results.each do |result| 
                    puts "#{results.index(result)+1}. #{result.title.greenish} : #{result.company.blue}"
                end
            end
            puts "-------------------------"
            puts "Please enter the number of the job you want to know more about (0 exits preview):"
            user_input = gets.strip.to_i
            puts "-------------------------"
            if (user_input < 0 || user_input > results.size)
                puts "not a valid number!"
            elsif (user_input == 0)
                exit_flag = true
            else
                puts "#{results[user_input-1].title.greenish} : #{results[user_input-1].company.blue}\n\n"
                puts results[user_input-1].description
                puts "-------------------------"
            end
        end
    end

    def search_for_jobs(user)
        puts "Please enter your #{"preferred job title".blue}, #{"benefits".blue}, #{"companies".blue}, or #{"expertise".blue}:"
        user.wants_type_of_job = gets.strip
        puts "-------------------------"
        puts "Great! Now, please enter the #{"zipcode".blue} or #{"name of the area".blue} you'd like to search in:"
        user.location = gets.strip
        puts "-------------------------"
        puts "Would you like to restrict your search to full time jobs? (#{"yes".green}/#{"no".red})"
        user.wants_fulltime = gets.strip
        if user.wants_fulltime == "yes"
            user.wants_fulltime = "on"
        elsif user.wants_fulltime == "no"
            user.wants_fulltime = "off"
        else
            puts "ERROR: not a valid answer!!! defaulting to no..."
            user.wants_fulltime = "off"
        end
        puts "-------------------------"
        puts "Processing your job search..."
        results = Parser.get_results(description: user.wants_type_of_job, location: user.location, full_time: user.wants_fulltime)
        puts "#{"Done!".green}"
        puts "-------------------------"

        preview_jobs(results)

        puts "Select which jobs to save"
        saving = gets.strip
        saving = saving.split(" ")
        saved_jobs_array = []

        index = 0
        while index < saving.size
            saved_jobs_array << results[saving[index].to_i-1]
            index += 1
        end

        Parser.save_jobs(jobs: saved_jobs_array, user: user)
        
        puts "Saved!".green
    end
end