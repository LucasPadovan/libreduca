# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( *.svg *.eot *.woff *.ttf *.png *.gif application-ie.js )