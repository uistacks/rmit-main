# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
# --------------------global plugins ------------------------------#
Rails.application.config.assets.precompile += %w( toastr.min.js )
Rails.application.config.assets.precompile += %w( toastr.min.css)
Rails.application.config.assets.precompile += %w( croppie.css)
Rails.application.config.assets.precompile += %w( croppie.js )
Rails.application.config.assets.precompile += %w( fusioncharts/fusioncharts.js )
Rails.application.config.assets.precompile += %w( fusioncharts/fusioncharts.charts.js )
Rails.application.config.assets.precompile += %w( fusioncharts/themes/fusioncharts.theme.fint.js )
# --------------------backend plugins ------------------------------#
Rails.application.config.assets.precompile += %w( admin/app.js )
Rails.application.config.assets.precompile += %w( admin/plugins/dataTables/datatables.min.js )
Rails.application.config.assets.precompile += %w( admin/jquery.validate-1.14.0.js )
Rails.application.config.assets.precompile += %w( admin/profile.js )
Rails.application.config.assets.precompile += %w( admin/plugins/chosen/chosen.jquery.js )
#css
Rails.application.config.assets.precompile += %w( admin/animate.css)
Rails.application.config.assets.precompile += %w( admin/style.css)
Rails.application.config.assets.precompile += %w( admin/font-awesome.css)
Rails.application.config.assets.precompile += %w( admin/plugins/dataTables/datatables.min.css)
Rails.application.config.assets.precompile += %w( admin/plugins/chosen/chosen.css)
# --------------------backend plugins ------------------------------#

# --------------------frontend plugins ------------------------------#
Rails.application.config.assets.precompile += %w( front/jquery.min.js )
Rails.application.config.assets.precompile += %w( front/bootstrap.min.js )
Rails.application.config.assets.precompile += %w( front/respond.js )
Rails.application.config.assets.precompile += %w( front/html5shiv.js )
Rails.application.config.assets.precompile += %w( front/owl.carousel.js )
Rails.application.config.assets.precompile += %w( front/scrollIt.min.js )
Rails.application.config.assets.precompile += %w( front/skrollr.min.js )
Rails.application.config.assets.precompile += %w( front/video-js.js )
Rails.application.config.assets.precompile += %w( front/custom.js )

Rails.application.config.assets.precompile += %w( front/jquery.ddslick.min.js )
Rails.application.config.assets.precompile += %w( front/custom-dropdown.js )
Rails.application.config.assets.precompile += %w( front/jquery-ui.js )
Rails.application.config.assets.precompile += %w( front/jquery.geocomplete.min.js )
Rails.application.config.assets.precompile += %w( front/lightslider.js )
#css
Rails.application.config.assets.precompile += %w( front/custom-dropdown.css )
Rails.application.config.assets.precompile += %w( front/lightslider.css )
# --------------------frontend plugins ------------------------------#
