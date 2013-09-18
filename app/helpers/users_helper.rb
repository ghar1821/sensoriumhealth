module UsersHelper

    # Returns the Gravatar (http://gravatar/com/) for the given user.
    # @param: user object.
    # @return: image tag for Gravatar with a "gravatar" class
    def gravatar_for(user)
        # Gravatar URLs are based on an MD5 hash of the user's email address.
        # Ruby's MD5 hashing algorithm is implemented using the hexdigest method.
        # Hexdigest method is part of Digest library.
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
        image_tag(gravatar_url, alt: user.username, class: "gravatar")
    end
end
