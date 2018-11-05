class Api::V1::Visits::ProcessVisit
  prepend SimpleCommand

  def initialize(owner, ipaddr)
    @owner  = owner
    @ipaddr = Api::V1::Visits::ProcessVisit.normalize(ipaddr)
  end


  def call
    return visit.save if visit.valid?

    errors.add(:visit, I18n.t('visit.visit_invalid'))
  end

  private
    attr_reader :owner, :ipaddr

    def self.normalize(ipaddr)
      ipaddr == '127.0.0.1' ? ipaddr = '1.2.3.4' : ipaddr
    end

    def visit
      Visit.new(
        country: country,
        ipaddr: ipaddr,
        url_id: owner.id
      )
    end

    def country
      Country[Geocoder.search(ipaddr).first.country]&.name ||
      Geocoder.search(ipaddr).first.country
    end
end
