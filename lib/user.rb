class User
    attr_accessor :location, :saved_jobs, :wants_fulltime, :wants_type_of_job

    def initialize(location: "", saved_jobs: [], wants_fulltime: "", wants_type_of_job: "")
        @location = location
        @saved_jobs = saved_jobs
        @wants_fulltime = wants_fulltime
        @wants_type_of_job = wants_type_of_job
    end

    def save_job(job)
        @saved_jobs << job
    end
end