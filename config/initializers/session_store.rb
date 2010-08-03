# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_cinema_showtimes_session',
  :secret      => 'b2bb9453360906aa887dd39d4ebb6182f6f2e2747ecd4360635a60508d6c74d6d07c52e52225b2d66ddd719dbd6689b7528582078bdf12c89e7fe047a5b3f038'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
