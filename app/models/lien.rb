require 'net/http'
class Lien < ActiveRecord::Base
  has_many :auteurs, :through => :liens_auteurs
  has_many :liens_auteurs
  has_many :liens_votes_positifs
  has_many :liens_votes_negatifs
  has_many :liens_votes
  belongs_to :lien_signaler
  #image_accessor :image_lien
  
  validates :url_lien, :presence => true
  #validates_format_of :url_lien , :with=> URI::regexp, :message => "Url invalide !!"  #
  #/^(?:([a-z0-9+.-]+:\/\/)((?:(?:[a-z0-9-._~!$&'()*+,;=:]|%[0-9A-F]{2})*)@)?((?:[a-z0-9-._~!$&'()*+,;=]|%[0-9A-F]{2})*)(:(?:\d*))?(\/(?:[a-z0-9-._~!$&'()*+,;=:@\/]|%[0-9A-F]{2})*)?|([a-z0-9+.-]+:)(\/?(?:[a-z0-9-._~!$&'()*+,;=:@]|%[0-9A-F]{2})+(?:[a-z0-9-._~!$&'()*+,;=:@\/]|%[0-9A-F]{2})*)?)(\?(?:[a-z0-9-._~!$&'()*+,;=:\/?@]|%[0-9A-F]{2})*)?(#(?:[a-z0-9-._~!$&'()*+,;=:\/?@]|%[0-9A-F]{2})*)?$/, :message => "Url invalide !!"  #URI::regexp#/((www|https):\/\/|[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)+.*)$/  
end
