class ProcessVisitWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(url_id, ip)
    url = Url.find(url_id)
    Api::V1::Urls::BuildVisit.call(url, ip)
  end
end
