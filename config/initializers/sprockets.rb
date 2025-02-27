Rails.application.configure do
  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  config.assets.precompile += %w[ custom.js custom.css ]
end
