<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/" lang="{% for language in languages %}{% if language.active %}{{ language.lang }}{% endif %}{% endfor %}">
    <head>
        <link rel="preconnect" href="{{ store_resource_hints }}" />
        <link rel="dns-prefetch" href="{{ store_resource_hints }}" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>{{ page_title }}</title>
        <meta name="description" content="{{ page_description }}" />
        <link rel="preload" as="style" href="{{ [settings.font_headings, settings.font_rest] | google_fonts_url('400,600') }}" />
        <link rel="preload" href="{{ 'css/style-critical.scss' | static_url }}" as="style" />
        <link rel="preload" href="{{ 'js/external-no-dependencies.js.tpl' | static_url }}" as="script" />

        {# Preload LCP home, category and product page elements #}
        
        {% snipplet 'preload-images.tpl' %}

        {{ component('social-meta') }}

        {#/*============================================================================
            #CSS and fonts
        ==============================================================================*/#}

        <style>
            {# Font families #}

            {{ component(
                'fonts',{
                    font_weights: '400,600',
                    font_settings: 'settings.font_headings, settings.font_rest'
                })
            }}

            {# General CSS Tokens #}

            {% include "static/css/style-tokens.tpl" %}

            .section-adbar, .js-adbar, [data-store="advertising-bar"],
            [data-slot="after_header"],
            [data-nubesdk-slot="after_header"],
            .js-nubesdk-slot[data-nubesdk-slot="after_header"],
            div[data-slot="after_header"] {
                display: none !important;
            }

            /* Action Max - Cards de Produto */
            /* Action Max - Cards de Produto Remodelados */
            .item-product .item,
            .js-item-product .item,
            .item-product.item {
                border: 1px solid #e5e7eb !important;
                border-top: 4px solid #c0392b !important;
                border-radius: 14px !important;
                background-color: #ffffff !important;
                overflow: hidden !important;
                box-shadow: 0 4px 14px rgba(0, 0, 0, 0.04) !important;
                transition: transform 0.2s ease, box-shadow 0.2s ease !important;
                text-align: left !important;
                padding: 12px 10px 14px !important;
                display: flex !important;
                flex-direction: column !important;
                justify-content: space-between !important;
                height: calc(100% - 15px) !important;
                margin-bottom: 15px !important;
            }
            .item-product .item:hover,
            .js-item-product .item:hover {
                transform: translateY(-2px) !important;
                box-shadow: 0 8px 22px rgba(0, 0, 0, 0.08) !important;
            }
            .item-product .item-image,
            .js-item-product .item-image {
                border-radius: 10px !important;
                overflow: hidden !important;
                background: #ffffff !important;
            }
            .item-product .item-description,
            .js-item-product .item-description {
                background: transparent !important;
                padding: 8px 2px 0 !important;
                text-align: left !important;
                flex-grow: 1 !important;
                display: flex !important;
                flex-direction: column !important;
                justify-content: space-between !important;
            }
            .item-product .item-name,
            .js-item-product .item-name {
                font-size: 13.5px !important;
                font-weight: 700 !important;
                color: #111827 !important;
                opacity: 1 !important;
                text-align: left !important;
                margin-bottom: 4px !important;
                line-height: 1.35 !important;
                display: -webkit-box !important;
                -webkit-line-clamp: 2 !important;
                -webkit-box-orient: vertical !important;
                overflow: hidden !important;
                text-decoration: none !important;
            }
            .item-product .item-link {
                text-decoration: none !important;
                color: inherit !important;
            }

            /* Container inferior: Canto Esquerdo e Canto Direito */
            .item-product .item-details-container,
            .js-item-product .item-details-container {
                display: flex !important;
                flex-direction: column !important;
                gap: 8px !important;
                margin-top: 8px !important;
                width: 100% !important;
            }
            .item-product .item-details-row,
            .js-item-product .item-details-row {
                display: flex !important;
                justify-content: space-between !important;
                align-items: flex-end !important;
                width: 100% !important;
                gap: 6px !important;
            }
            .item-product .item-details-left,
            .js-item-product .item-details-left {
                display: flex !important;
                flex-direction: column !important;
                justify-content: flex-end !important;
                text-align: left !important;
                flex: 1 1 auto !important;
                min-width: 0 !important;
            }

            /* Canto esquerdo: Preço original rasurado cinzento */
            .item-product .item-price-compare,
            .js-item-product .item-price-compare {
                font-size: 11.5px !important;
                color: #9ca3af !important;
                text-decoration: line-through !important;
                line-height: 1.2 !important;
                margin-bottom: 1px !important;
                display: block !important;
            }
            .item-product .item-price-compare .price-compare,
            .js-item-product .item-price-compare .price-compare {
                color: #9ca3af !important;
                text-decoration: line-through !important;
                font-size: 11.5px !important;
            }

            /* Canto esquerdo: Preço promocional em destaque em vermelho mostrando em 6 parcelas */
            .item-product .item-price-promo,
            .js-item-product .item-price-promo {
                line-height: 1.2 !important;
            }
            .item-product .item-price-installment,
            .js-item-product .item-price-installment {
                color: #c0392b !important;
                font-size: 15px !important;
                font-weight: 800 !important;
                display: block !important;
                text-align: left !important;
                line-height: 1.2 !important;
                white-space: nowrap !important;
            }
            .item-product .item-price.d-none,
            .js-item-product .item-price.d-none {
                display: none !important;
            }
            .item-product .item-price-cash,
            .js-item-product .item-price-cash {
                font-size: 11px !important;
                color: #64748b !important;
                font-weight: 500 !important;
                text-align: left !important;
                margin-top: 2px !important;
                line-height: 1.2 !important;
                white-space: nowrap !important;
            }
            .item-product .item-price-cash .js-payment-discount-price-container,
            .js-item-product .item-price-cash .js-payment-discount-price-container {
                font-size: 11px !important;
                color: #64748b !important;
                font-weight: 500 !important;
                display: inline-block !important;
                margin: 0 !important;
            }

            /* Canto direito: estrela amarela com nota */
            .item-product .item-details-right,
            .js-item-product .item-details-right {
                display: flex !important;
                align-items: flex-end !important;
                justify-content: flex-end !important;
                flex: 0 0 auto !important;
                text-align: right !important;
                padding-bottom: 2px !important;
            }
            .item-product .item-rating,
            .js-item-product .item-rating {
                display: inline-flex !important;
                align-items: center !important;
                justify-content: flex-end !important;
                gap: 3px !important;
                line-height: 1 !important;
                background: #fffbeb !important;
                border: 1px solid #fef3c7 !important;
                padding: 3px 6px !important;
                border-radius: 6px !important;
            }
            .item-product .item-star-icon,
            .js-item-product .item-star-icon {
                width: 14px !important;
                height: 14px !important;
                fill: #f59e0b !important;
                flex-shrink: 0 !important;
                display: inline-block !important;
                vertical-align: -1px !important;
            }
            .item-product .item-rating-score,
            .js-item-product .item-rating-score {
                font-size: 12.5px !important;
                font-weight: 800 !important;
                color: #92400e !important;
            }

            /* Botão vermelho com fonte branca abaixo */
            .item-product .item-actions,
            .js-item-product .item-actions {
                margin-top: 4px !important;
                text-align: center !important;
                width: 100% !important;
            }
            .item-product .item-actions .btn,
            .js-item-product .item-actions .btn,
            .item-product .btn-add-to-cart,
            .js-item-product .btn-add-to-cart,
            .item-product .item-actions input[type="submit"],
            .js-item-product .item-actions input[type="submit"] {
                width: 100% !important;
                border-radius: 8px !important;
                font-size: 12px !important;
                font-weight: 700 !important;
                padding: 8px 12px !important;
                background-color: #c0392b !important;
                border: 1px solid #c0392b !important;
                color: #ffffff !important;
                transition: background-color 0.2s ease, transform 0.15s ease !important;
                cursor: pointer !important;
                display: block !important;
                text-align: center !important;
                line-height: 1.2 !important;
                white-space: nowrap !important;
                text-decoration: none !important;
            }
            .item-product .item-actions .btn:hover,
            .js-item-product .item-actions .btn:hover,
            .item-product .btn-add-to-cart:hover,
            .js-item-product .btn-add-to-cart:hover,
            .item-product .item-actions input[type="submit"]:hover,
            .js-item-product .item-actions input[type="submit"]:hover {
                background-color: #a93226 !important;
                border-color: #a93226 !important;
                color: #ffffff !important;
                transform: translateY(-1px) !important;
            }

            /* Esconde placeholder que exibia texto antigo Comprar */
            .item-product .item-actions .js-addtocart-placeholder,
            .js-item-product .item-actions .js-addtocart-placeholder {
                display: none !important;
            }

            @media (max-width: 576px) {
                .item-product .item-price-installment,
                .js-item-product .item-price-installment {
                    font-size: 13px !important;
                }
                .item-product .item-price-cash,
                .js-item-product .item-price-cash {
                    font-size: 10px !important;
                }
                .item-product .item-actions .btn,
                .js-item-product .item-actions .btn,
                .item-product .btn-add-to-cart,
                .js-item-product .btn-add-to-cart,
                .item-product .item-actions input[type="submit"],
                .js-item-product .item-actions input[type="submit"] {
                    font-size: 11px !important;
                    padding: 7px 8px !important;
                }
                .item-product .item-rating-score,
                .js-item-product .item-rating-score {
                    font-size: 11.5px !important;
                }
                .item-product .item-star-icon,
                .js-item-product .item-star-icon {
                    width: 12px !important;
                    height: 12px !important;
                }
            }

            /* Action Max - Banner de Confiança Integrado ao Rodapé (Tela Cheia) */
            .section-footer-trust {
                width: 100% !important;
                background-color: #000000 !important;
                border-top: 1px solid #1f2937 !important;
                border-bottom: none !important;
                margin-top: 40px !important;
                margin-bottom: 0 !important;
                padding-top: 45px !important;
                padding-bottom: 25px !important;
                display: block !important;
            }
            .footer-trust-wrapper {
                max-width: 640px !important;
                margin: 0 auto !important;
                padding: 0 15px !important;
                text-align: left !important;
                color: #ffffff !important;
            }
            .footer-trust-title {
                font-size: 21px !important;
                font-weight: 900 !important;
                line-height: 1.25 !important;
                color: #ffffff !important;
                text-transform: uppercase !important;
                letter-spacing: -0.01em !important;
                margin-bottom: 24px !important;
                font-family: 'Montserrat', sans-serif !important;
                text-align: left !important;
            }
            .footer-trust-list {
                list-style: none !important;
                padding: 0 !important;
                margin: 0 0 24px 0 !important;
                display: flex !important;
                flex-direction: column !important;
                gap: 15px !important;
            }
            .footer-trust-item {
                display: flex !important;
                align-items: center !important;
                gap: 14px !important;
                color: #f4f4f5 !important;
                font-size: 15px !important;
                line-height: 1.35 !important;
                font-family: 'Red Hat Display', sans-serif !important;
            }
            .footer-trust-icon {
                width: 22px !important;
                height: 22px !important;
                display: inline-flex !important;
                align-items: center !important;
                justify-content: center !important;
                flex-shrink: 0 !important;
                color: #ffffff !important;
            }
            .footer-trust-icon svg {
                width: 19px !important;
                height: 19px !important;
                stroke: #ffffff !important;
            }
            .footer-trust-text {
                font-weight: 500 !important;
                color: #f4f4f5 !important;
            }
            .footer-trust-tagline {
                font-size: 15px !important;
                color: #a1a1aa !important;
                font-weight: 500 !important;
                line-height: 1.4 !important;
                font-family: 'Red Hat Display', sans-serif !important;
                text-align: left !important;
            }
            .footer-trust-tagline strong {
                color: #ffffff !important;
                font-weight: 800 !important;
            }
            footer.js-footer {
                margin-top: 0 !important;
            }

            @media (max-width: 576px) {
                .section-footer-trust {
                    margin-top: 30px !important;
                    padding-top: 35px !important;
                    padding-bottom: 20px !important;
                }
                .footer-trust-wrapper {
                    padding: 0 8px !important;
                }
                .footer-trust-title {
                    font-size: 18px !important;
                    margin-bottom: 20px !important;
                }
                .footer-trust-item {
                    font-size: 13.5px !important;
                    gap: 12px !important;
                }
                .footer-trust-icon svg {
                    width: 17px !important;
                    height: 17px !important;
                }
                .footer-trust-tagline {
                    font-size: 14px !important;
                }
            }
        </style>

        {# Critical CSS #}

        {{ 'css/style-critical.scss' | static_url | static_inline }}

        {# Load async styling not mandatory for first meaningfull paint #}

        <link rel="stylesheet" href="{{ 'css/style-async.scss' | static_url }}" media="print" onload="this.media='all'">

        {# Loads custom CSS added from Advanced Settings on the admin´s theme customization screen #}

        <style>
            {{ settings.css_code | raw }}
        </style>

        {#/*============================================================================
            #Javascript: Needed before HTML loads
        ==============================================================================*/#}

        {# Defines if async JS will be used by using script_tag(true) #}

        {% set async_js = true %}

        {# Defines the usage of jquery loaded below, if nojquery = true is deleted it will fallback to jquery 1.5 #}

        {% set nojquery = true %}

        {# Jquery async by adding script_tag(true) #}

        {% if load_jquery %}

            {{ '//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js' | script_tag(true) }}

        {% endif %}

        {# Loads private Tiendanube JS #}

        {% head_content %}

        {# Structured data to provide information for Google about the page content #}

        {{ component('structured-data-organization') }}
        {{ component('structured-data') }}

    </head>
    <body class="{% if customer %}customer-logged-in{% endif %} template-{{ template | replace('.', '-') }}">

        {{ component('nubesdk-slot', { type: "before_main_content" }) }}

        {# Theme icons #}

        {% include "snipplets/svg/icons.tpl" %}

        {# Facebook comments on product page #}

        {% if template == 'product' %}

            {# Facebook comment box JS #}
            {% if settings.show_product_fb_comment_box %}
                {{ fb_js }}
            {% endif %}

            {# Pinterest share button JS #}
            {{ pin_js }}

        {% endif %}

        {# Back to admin bar #}

        {{back_to_admin}}

        {# Header = Advertising + Nav + Logo + Search + Ajax Cart #}

        {% snipplet "header/header.tpl" %}

        {# Page content #}

        {% template_content %}

        {# Quickshop modal #}

        {% snipplet "grid/quick-shop.tpl" %}

        {# WhatsApp chat button #}

        {% snipplet "whatsapp-chat.tpl" %}

        {# Banner de Confiança Acima do Rodapé #}
        {% if template != 'password' %}
            {% include 'snipplets/footer-trust.tpl' %}
        {% endif %}

        {# Footer #}

        {% snipplet "footer/footer.tpl" %}

        {% if cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}

            {# Minimum used for free shipping progress messages. Located on header so it can be accesed everywhere with shipping calculator active or inactive #}

            <span class="js-ship-free-min hidden" data-pricemin="{{ cart.free_shipping.min_price_free_shipping.min_price_raw }}"></span>
            <span class="js-free-shipping-config hidden" data-config="{{ cart.free_shipping.allFreeConfigurations }}"></span>
            <span class="js-cart-subtotal hidden" data-priceraw="{{ cart.subtotal }}"></span>
            <span class="js-cart-discount hidden" data-priceraw="{{ cart.promotional_discount_amount }}"></span>
        {% endif %}

        {#/*============================================================================
            #Javascript: Needed after HTML loads
        ==============================================================================*/#}

        {# Javascript used in the store #}

        {# Critical libraries #}

        {{ 'js/external-no-dependencies.js.tpl' | static_url | script_tag }}

        <script type="text/javascript">

            {# LS.ready.then function waits to Jquery and private Tiendanube JS to be loaded before executing what´s inside #}

            LS.ready.then(function(){

                {# Non critical libraries #}

                {% include "static/js/external.js.tpl" %}

                {# Specific store JS functions: product variants, cart, shipping, etc #}

                {% include "static/js/store.js.tpl" %}
            });
        </script>

        {# Google survey JS for Tiendanube Survey #}

        {{ component('google-survey') }}

        {# Store external codes added from admin #}

        {% if store.assorted_js %}
            <script>
                LS.ready.then(function() {
                    var trackingCode = jQueryNuvem.parseHTML('{{ store.assorted_js| escape("js") }}', document, true);
                    jQueryNuvem('body').append(trackingCode);
                });
            </script>
        {% endif %}
        <script>
            (function() {
                function removeAdbar() {
                    var els = document.querySelectorAll('.section-adbar, .js-adbar, [data-store="advertising-bar"], [data-slot="after_header"], [data-nubesdk-slot="after_header"], div[data-slot="after_header"]');
                    els.forEach(function(el) { el.style.setProperty('display', 'none', 'important'); el.remove(); });
                }
                removeAdbar();
                if (document.readyState === 'loading') {
                    document.addEventListener('DOMContentLoaded', removeAdbar);
                }
            })();
        </script>
    </body>
</html>
