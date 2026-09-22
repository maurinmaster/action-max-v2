{# /*============================================================================
  #Page header
==============================================================================*/

#Properties

#Title

#Breadcrumbs

#}

{% set padding = padding ?? true %}
{% set container = container ?? true %}
{% set page_header_title_default_classes = template == 'product' ? 'h1-md' : 'h1-huge-md' %}

{% if container %}
	<div class="container">
{% endif %}
		<section class="page-header {% if padding %}py-4{% endif %} {{ page_header_class }}" data-store="page-title">
				{% include 'snipplets/breadcrumbs.tpl' %}
				{% if template == 'product' %}

					{{ component('nubesdk-slot', { type: "before_product_detail_name" }) }}

				{% endif %}
				<h1 class="h2 {{ page_header_title_default_classes }} {{ page_header_title_class }}" {% if template == "product" %}data-store="product-name-{{ product.id }}"{% endif %}>{% block page_header_text %}{% endblock %}</h1>
				{% if template == 'product' %}

					{{ component('nubesdk-slot', { type: "after_product_detail_name" }) }}

				{% endif %}
		</section>
{% if container %}
	</div>
{% endif %}
