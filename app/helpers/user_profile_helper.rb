module UserProfileHelper
  TEMPLATES = {
    twitter: {url:'https://x.com/$nickname', icon: 'fa fa-twitter'},
    linkedin: {url:'https://linkedin.com/in/$nickname', icon: 'fa fa-linkedin'},
    github: {url:'https://github.com/$nickname', icon: 'fa fa-github'},
    facebook: {url:'https://facbook.com/$nickname', icon: 'fa fa-facebook'},
  }
  def social_url(user)
    TEMPLATES.dig(user.nickname_type.to_sym)&.[](:url).sub('$nickname', user.nickname)
  end
  
  def social_icon_class(user)
    TEMPLATES.dig(user.nickname_type.to_sym)&.[](:icon)
  end

  private

end
