class Comment < ActiveRecord::Base
  
  URL_REGEX = Regexp.new(String.new("^(https?://)?" +
                                    "(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" + #user@
                                    "(([0-9]{1,3}\.){3}[0-9]{1,3}" + # IP- 199.194.52.184
                                    "|" + # allows either IP or domain
                                    "([0-9a-z_!~*'()-]+\.)*" + # tertiary domain(s)- www.
                                    "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." + # second level domain
                                    "[a-z]{2,6})" + # first level domain- .com or .museum
                                    "(:[0-9]{1,4})?" + # port number- :80
                                    "((/?)|" + # a slash isn't required if there is no file name
                                    "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$"))

  belongs_to :article
  
  validates_presence_of :content
  validates_presence_of :author_email
  validates_presence_of :article
  validates_presence_of :article_id
  
  validates_format_of :homepage, :with => URL_REGEX
end
