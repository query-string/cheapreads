class BooksSynchronizeJob < Que::Job
  def run
    ActiveRecord::Base.transaction do
      destroy
    end
  end
end
