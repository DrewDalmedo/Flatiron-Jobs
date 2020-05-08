class Job
    attr_accessor :title, :type, :company, :githubjobs_url, :company_url, :created_at, :location, :description, :how_to_apply

    def initialize(attributes)
        attributes.each {|key, value| self.send(("#{key}="), value)}
    end
end