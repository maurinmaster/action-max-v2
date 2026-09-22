{% if home_main_product %}
	{% set has_multiple_slides = product.media_count > 1 %}
{% else %}
	{% set has_multiple_slides = product.media_count > 1 or product.video_url %}
{% endif %}

{{ component('nubesdk-slot', { type: "before_product_detail_image" }) }}

<div class="row" data-store="product-image-{{ product.id }}"> 
	{% if has_multiple_slides %}
		<div class="{% if home_main_product %}d-none d-md-block{% else %} order-last order-md-0{% endif %} col-md-auto pr-md-0 mt-3 mt-md-0">
			<div class="product-thumbs-container position-relative">
				<div class="text-center d-none d-md-block">
					<div class="js-swiper-product-thumbs-prev swiper-button-prev swiper-product-thumb-control  svg-icon-text">
						<svg class="icon-inline icon-lg icon-flip-vertical"><use xlink:href="#chevron-down"/></svg>
					</div>
				</div>
				<div class="js-swiper-product-thumbs swiper-product-thumb"> 
					<div class="swiper-wrapper">
						{% for media in product.media %}
							<div class="swiper-slide w-auto">
								{% include 'snipplets/product/product-image-thumbs.tpl' %}
							</div>
						{% endfor %}
						{% if not home_main_product %}
							{# Video thumb #}
							<div class="swiper-slide w-auto">
								{% include 'snipplets/product/product-video.tpl' with {thumb: true} %}
							</div>
						{% endif %}
					</div>
				</div>
				<div class="text-center d-none d-md-block">
					<div class="js-swiper-product-thumbs-next swiper-button-next swiper-product-thumb-control  svg-icon-text">
						<svg class="icon-inline icon-lg"><use xlink:href="#chevron-down"/></svg>
					</div>
				</div>
			</div>
		</div>
	{% endif %}
	{% if product.media_count > 0 %}
		<div class="col-md {% if not has_multiple_slides %}product-with-one-image pr-md-3{% else %}p-0 px-md-3{% endif %}">
			<div class="js-swiper-product swiper-container product-detail-slider" data-product-images-amount="{{ product.media_count }}">

                {{ component('nubesdk-slot', { type: "product_detail_image" }) }}

                {% include 'snipplets/labels.tpl' with {product_detail: true, labels_floating: true} %}
				<div class="swiper-wrapper">
					{% for media in product.media %}
						{% if media.isImage %}
							<div class="js-product-slide w-100 swiper-slide product-slide{% if home_main_product %}-small{% endif %} slider-slide" data-image="{{media.id}}" data-image-position="{{loop.index0}}">
								{% if home_main_product %}
									<div class="js-product-slide-link d-block position-relative" style="padding-bottom: {{ media.dimensions['height'] / media.dimensions['width'] * 100}}%;">
								{% else %}
									<a href="{{ media | product_image_url('4k') }}" data-fancybox="product-gallery" class="js-product-slide-link d-block position-relative" style="padding-bottom: {{ media.dimensions['height'] / media.dimensions['width'] * 100}}%;">
								{% endif %}

									{% set apply_lazy_load = home_main_product or not loop.first %}

									{% if apply_lazy_load %}
										{% set product_image_src = 'data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==' %}
									{% else %}
										{% set product_image_src = media | product_image_url('large') %}
									{% endif %}

									<img 
										{% if not apply_lazy_load %}fetchpriority="high"{% endif %}
										{% if apply_lazy_load %}data-{% endif %}src="{{ product_image_src }}"
										{% if apply_lazy_load %}data-{% endif %}srcset='{{  media | product_image_url('large') }} 480w, {{  media | product_image_url('huge') }} 640w, {{  media | product_image_url('original') }} 1024w, {{  media | product_image_url('1080p') }} 1920w, {{  media | product_image_url('1440p') }} 2560w, {{  media | product_image_url('4k') }} 3840w' 
										class="js-product-slide-img product-slider-image img-absolute img-absolute-centered {% if apply_lazy_load %}lazyautosizes lazyload{% endif %}" 
										{% if apply_lazy_load %}data-sizes="auto"{% endif %}
										{% if media.dimensions.width and media.dimensions.height %}width="{{ media.dimensions.width }}" height="{{ media.dimensions.height }}"{% endif %}
										{% if media.alt %}alt="{{media.alt}}"{% endif %} />
								{% if home_main_product %}
									</div>
								{% else %}
									</a>
								{% endif %}
							</div>
						{% else %}
							{% include 'snipplets/product/product-video.tpl' with {video_id: media.next_video, product_native_video: true, home_main_product: home_main_product} %}
						{% endif %}
					{% endfor %}
					{% if not home_main_product %}
						{% include 'snipplets/product/product-video.tpl' with {video_id: 'yt'} %}
					{% endif %}
				</div>
			</div>
			{% if has_multiple_slides and home_main_product %}
				<div class="js-swiper-product-pagination swiper-pagination position-relative pt-3 pb-1 d-md-none"></div>
			{% endif %}
		</div>
	{% endif %}
</div>

{{ component('nubesdk-slot', { type: "after_product_detail_image" }) }}