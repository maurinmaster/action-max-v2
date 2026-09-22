{% set newsletter_image = "home_news_image.jpg" | has_custom_image %}
{% set newsletter_mobile_image = "home_news_image_mobile.jpg" | has_custom_image %}
{% set newsletter_images = newsletter_image or newsletter_mobile_image %}

{% set newsletter_colors_full = settings.newsletter_full and settings.home_news_colors %}

<section class="section-home section-newsletter visible-when-content-ready" data-store="home-newsletter">

    {{ component('nubesdk-slot', { type: 'before_section_newsletter' }) }}

	<div class="js-home-newsletter-section container{% if settings.newsletter_full %}-fluid p-0{% endif %}">
		<div class="js-home-newsletter-container section-newsletter-home {% if settings.home_news_colors %}section-newsletter-home-colors{% endif %} {% if newsletter_images %}section-newsletter-home-images{% endif %} position-relative overflow-none">
			{% if newsletter_images or params.preview %}
				<div class="js-home-newsletter-image-container" {% if not (newsletter_image or newsletter_mobile_image) %} style="display:none;"{% endif %}>
					<img {% if newsletter_image %}src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset='{{ "home_news_image.jpg" | static_url | settings_image_url('large') }} 480w, {{ "home_news_image.jpg" | static_url | settings_image_url('huge') }} 640w, {{ "home_news_image.jpg" | static_url | settings_image_url('original') }} 1024w, {{ "home_news_image.jpg" | static_url | settings_image_url('1080p') }} 1920w'{% endif %} class='js-home-newsletter-image lazyload background-home-image fade-in {% if newsletter_mobile_image %}d-none d-md-block{% endif %}'{% if not newsletter_image %} style="display: none;"{% endif %}/>
					<img {% if newsletter_mobile_image %}src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset='{{ "home_news_image_mobile.jpg" | static_url | settings_image_url('large') }} 480w, {{ "home_news_image_mobile.jpg" | static_url | settings_image_url('huge') }} 640w, {{ "home_news_image_mobile.jpg" | static_url | settings_image_url('original') }} 1024w, {{ "home_news_image_mobile.jpg" | static_url | settings_image_url('1080p') }} 1920w' {% endif %} class="js-home-newsletter-image-mobile lazyload background-home-image fade-in {% if newsletter_image %}d-block d-md-none{% endif %}"{% if not newsletter_mobile_image %} style="display: none;"{% endif %}/>
				</div>
			{% endif %}
			<div class="js-home-newsletter-internal-container {% if settings.newsletter_full %}container px-4 px-md-3{% else %}mx-4 mx-md-5{% endif %}">
				<div class="js-home-newsletter newsletter-container position-relative {% if settings.home_news_align == 'center' %}text-center m-auto{% endif %}">
					{% include "snipplets/newsletter.tpl" with {
						home_newsletter: true,
						form_data_store: 'home-newsletter-form',
					} %}
				</div>
			</div>
		</div>
	</div>

    {{ component('nubesdk-slot', { type: 'after_section_newsletter' }) }}

</section>
