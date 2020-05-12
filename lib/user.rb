class User
    attr_accessor :location, :saved_jobs, :wants_fulltime, :wants_type_of_job

    def initialize(location: "", saved_jobs: [], wants_fulltime: "", wants_type_of_job: "")
        @location = location
        @saved_jobs = saved_jobs
        @wants_fulltime = wants_fulltime
        @wants_type_of_job = wants_type_of_job
    end

    '''
    # in a more complex program, jobs would be the ones to keep track of who has saved them (single source of truth)
    def saved_jobs()
        Job.all.select {|job| job.saved_by_users.include?(self)}
    end
    '''

    def save_job(job)
        @saved_jobs << job
    end

    def print_jobs()

        if @saved_jobs.size == 0
            puts "#{"You have not saved any jobs!".red}"
        else
            @saved_jobs.each do |job|
                puts "#{job.title.greenish} : #{job.company.blue}\n\n"
                puts "#{job.description}"
                #don't print if last job in array
                puts "-------------------------" if @saved_jobs.index(job) != @saved_jobs.size-1 
            end
        end
        
    end
end
