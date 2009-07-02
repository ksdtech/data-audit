# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_data-audit_session',
  :secret      => '33d6aeb06aa999fea59f19e95b4066b7bd4b88fef85cadd3c5b3cfb4c161e2878b39fd1da35100de0896f4a5f612cd888fcc22a1c5c211463f3fd78efe938576'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
