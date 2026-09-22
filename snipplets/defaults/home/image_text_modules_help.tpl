{# Modules that work as examples #}

{% set banner_view_box = '0 0 1440 770' %}

<div class="js-module-banner-placeholder">
	<div class="container p-0">
		{% for i in 1..2 %}
			<div class="textbanner mb-md-5">
				<div class="row no-gutters align-items-center">
					<div class="col-md-6">
						<svg viewBox='{{ banner_view_box }}'><use xlink:href="#slider-slide-placeholder"/></svg>
					</div>
					<div class="col-md-6 px-3 px-md-5 textbanner-text text-center {% if loop.index is even %}order-md-first{% endif %}">
						<div class="h1 mb-3 px-md-3">{{ 'Módulo de imagen y texto' | translate }}</div>
						<div class="mb-3 px-md-3 line-height-initial">{{ 'Usá este texto para compartir información de tu negocio, dar la bienvenida a tus clientes o para contar lo increíble que son tus productos.' | translate }}</div>
					</div>
				</div>
			</div>
		{% endfor %}
	</div>
	{% if not params.preview %}
		<div class="placeholder-overlay transition-soft">
			<div class="placeholder-info">
				<svg class="icon-inline icon-3x"><use xlink:href="#edit"/></svg>
				<div class="placeholder-description font-small-xs">
					{{ "Podés contar más sobre tu tienda desde" | translate }} <strong>"{{ "Módulos de imagen y texto" | translate }}"</strong>
				</div>
				<a href="{{ admin_link }}#instatheme=pagina-de-inicio" class="btn-primary btn btn-small placeholder-button">{{ "Editar" | translate }}</a>
			</div>
		</div>
	{% endif %}
</div>

{# Skeleton of "true" section accessed from instatheme.js #}
<div class="js-module-banner-top" style="display:none">    
	{% include 'snipplets/home/home-banners.tpl' with {'has_module': true} %}
</div>