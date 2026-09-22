{% set has_filters_available = products and has_filters_enabled and product_filters is not empty %}
{% if settings.pagination == 'infinite' %}
	{% if settings.grid_columns_desktop == '5' %}
		{% paginate by 15 %}
	{% else %}
		{% paginate by 12 %}
	{% endif %}
{% else %}
	{% if settings.grid_columns_desktop == '5' %}
		{% paginate by 50 %}
	{% else %}
		{% paginate by 48 %}
	{% endif %}
{% endif %}

<div class="container">
	{% embed "snipplets/page-header.tpl" with { breadcrumbs: false, container: false } %}
		{% block page_header_text %}
			{% if products %}
				{{ 'Resultados de búsqueda' | translate }}
			{% else %}
				{{ "No encontramos nada para" | translate }}<span class="ml-2">"{{ query }}"</span>
			{% endif %}
		{% endblock page_header_text %}
	{% endembed %}
	{% if products %}
		<h2 class="h5 mb-4 pb-2 font-weight-normal"> {{ "Mostrando los resultados para" | translate }}
			<span class="ml-2 font-weight-bold">"{{ query }}"</span>
		</h2>
	{% endif %}
</div>

{% include 'snipplets/grid/filters-modals.tpl' %}

<section class="category-body overflow-none">
	<div class="container mb-5 mt-3">
		<div class="row">
			{% include 'snipplets/grid/filters-sidebar.tpl' %}
			{% include 'snipplets/grid/products-list.tpl' %}
		</div>
	</div>
</section>