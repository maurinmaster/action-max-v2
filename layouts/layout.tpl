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
                text-align: center !important;
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
                padding: 8px 4px 0 !important;
                text-align: center !important;
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
                text-align: center !important;
                margin-bottom: 6px !important;
                line-height: 1.35 !important;
                display: -webkit-box !important;
                -webkit-line-clamp: 2 !important;
                -webkit-box-orient: vertical !important;
                overflow: hidden !important;
            }
            .item-product .item-price-container,
            .js-item-product .item-price-container {
                text-align: center !important;
                margin-top: 4px !important;
                margin-bottom: 4px !important;
            }
            .item-product .item-price-installment,
            .js-item-product .item-price-installment,
            .item-product .item-price-main-highlight .item-price:not(.d-none),
            .js-item-product .item-price-main-highlight .item-price:not(.d-none) {
                color: #c0392b !important;
                font-size: 15px !important;
                font-weight: 700 !important;
                display: block !important;
                text-align: center !important;
                line-height: 1.25 !important;
            }
            .item-product .item-price.d-none,
            .js-item-product .item-price.d-none {
                display: none !important;
            }
            .item-product .item-price-cash,
            .js-item-product .item-price-cash {
                font-size: 11.5px !important;
                color: #64748b !important;
                font-weight: 500 !important;
                text-align: center !important;
                margin-top: 3px !important;
                line-height: 1.3 !important;
            }
            .item-product .item-price-cash .js-payment-discount-price-container,
            .js-item-product .item-price-cash .js-payment-discount-price-container {
                font-size: 11.5px !important;
                color: #64748b !important;
                font-weight: 500 !important;
                display: inline-block !important;
                margin: 0 !important;
            }
            .item-product .item-price-cash .js-payment-discount-price-container::before,
            .js-item-product .item-price-cash .js-payment-discount-price-container::before {
                content: "ou ";
            }
            .item-product .item-actions,
            .js-item-product .item-actions {
                text-align: center !important;
                margin-top: 8px !important;
                width: 100% !important;
            }
            .item-product .item-actions .btn,
            .js-item-product .item-actions .btn {
                border-radius: 8px !important;
                font-size: 12px !important;
                font-weight: 600 !important;
                padding: 6px 14px !important;
                background-color: #c0392b !important;
                border-color: #c0392b !important;
                color: #ffffff !important;
                transition: background-color 0.2s ease !important;
            }
            .item-product .item-actions .btn:hover,
            .js-item-product .item-actions .btn:hover {
                background-color: #a93226 !important;
                border-color: #a93226 !important;
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
