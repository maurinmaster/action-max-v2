{# Site Overlay #}
<div class="js-overlay site-overlay" style="display: none;"></div>

{# Header #}

{# Header logo dynamic classes #}

{% set header_logo_mobile_classes = settings.logo_position_mobile == 'center' ? 'head-logo-center' : 'head-logo-left' %}
{% set header_logo_mobile_search_icon_classes = settings.logo_position_mobile == 'center' and not settings.search_big_mobile  ? 'head-logo-center-search-small' : '' %}
{% set header_logo_desktop_classes = settings.logo_position_desktop == 'center' ? 'head-logo-md-center' : 'head-logo-md-left' %}
{% set header_logo_left_nav_below_desktop_classes = settings.logo_position_desktop == 'left' and settings.search_big_desktop ? 'head-logo-md-left-nav-below' : '' %}

{# Header colors dynamic classes #}

{% set header_colors_classes = settings.header_colors ? 'head-colors' : '' %}

{# Logo mobile dynamic classes #}

{% set logo_mobile_classes = settings.logo_position_mobile == 'center' ? 'text-center' : 'ml-2 ml-md-0 text-left' %}

{# Logo desktop dynamic classes + utilities desktop order #}

{% set logo_desktop_classes = settings.logo_position_desktop == 'center' ? 'col-md-6 order-md-1 text-md-center' : 'col-md-auto order-md-first text-md-left pr-md-4' %}

{# Conditions for transparent head on page load #}

{# Slider and video presence #}

{% if template == 'home' %}
    {% set has_main_slider = settings.slider and settings.slider is not empty %}
    {% set has_mobile_slider = settings.toggle_slider_mobile and settings.slider_mobile and settings.slider_mobile is not empty %}
    {% set has_slider = has_main_slider or has_mobile_slider %}
    {% set has_slider_above_the_fold = settings.home_order_position_1 == 'slider' and has_slider %}
    {% set has_video_above_the_fold = settings.home_order_position_1 == 'video' and settings.video_embed %}
    {% set is_video_or_slider_above_the_fold = has_slider_above_the_fold or has_video_above_the_fold %}
{% endif %}

{# Transparent head conditions #}

{% set head_transparent_type_on_section = template == 'home' and settings.head_transparent and settings.head_transparent_type == 'slider_and_video' and (has_slider or settings.video_embed) %}
{% set head_transparent_type_always = settings.head_transparent and settings.head_transparent_type == 'all' %}
{% set head_transparent = (head_transparent_type_on_section or head_transparent_type_always) %}
{% set head_transparent_with_media = head_transparent and is_video_or_slider_above_the_fold %}

{% set header_transparent_classes = head_transparent_type_always ? 'js-head-mutator head-transparent' : head_transparent_type_on_section ? 'js-head-mutator head-transparent-on-section' %}
{% set head_transparent_color_class = head_transparent and settings.head_transparent_contrast_options ? 'head-transparent-contrast' %}
{% set head_transparent_logo_class = head_transparent and settings.head_transparent_contrast_options and "logo-transparent.jpg" | has_custom_image ? 'head-transparent-logo' %}

{# Adbar classes #}

{% set head_adbar_classes = '' %}

{# Header position type #}

{% set head_position_mobile = head_transparent_with_media ? 'position-fixed' : 'position-sticky' %}
{% set head_position_desktop = settings.head_fix_desktop 
    ? (head_transparent_with_media ? 'position-fixed-md' : 'position-sticky-md')
    : (head_transparent_with_media ? 'position-absolute-md' : 'position-relative-md') %}

{# Header visibility classes #}

{% set show_inline_desktop_hide_mobile_class = 'd-none d-md-inline-block' %}
{% set show_inline_mobile_hide_desktop_class = 'd-inline-block d-md-none' %}
{% set show_block_desktop_hide_mobile_class = 'd-none d-md-block' %}
{% set show_block_mobile_hide_desktop_class = 'd-block d-md-none' %}

{# Search classes #}

{% set search_icon_visibility_classes = '' %}
{% if settings.search_big_mobile and not settings.search_big_desktop %}
    {% set search_icon_visibility_classes = show_block_desktop_hide_mobile_class %}
{% elseif not settings.search_big_mobile and settings.search_big_desktop %}
    {% set search_icon_visibility_classes = show_block_mobile_hide_desktop_class %}
{% endif %}

{% set search_col_md_classes = settings.logo_position_desktop == 'center' ? 'col-md-3' : settings.search_big_desktop  ? 'col-md' : 'col-md-auto' %}

{# Utilities conditions #}

{% set hamburger_icon_spacing_classes = settings.logo_position_mobile == 'left' ? 'ml-1 ml-md-0' : '' %}
{% set account_icon_col_classes = settings.logo_position_desktop == 'center' ? 'col-md order-md-1' : 'col-md-auto' %}

{# Header desktop nav dynamic classes #}

{% set head_nav_inline_desktop_classes =  settings.logo_position_desktop == 'left' and not settings.search_big_desktop ? 'head-nav-md-inline' : '' %}

{% set head_desktop_nav_color_classes =  settings.desktop_nav_colors and not head_nav_inline_desktop_classes ? 'head-nav-desktop-colors' %}

{% set has_languages = languages | length > 1 and settings.languages_header %}

{% set head_languages_class = has_languages and settings.logo_position_mobile == 'center' and not settings.search_big_mobile and settings.logo_size == 'big' ? 'head-logo-center-language-small' %}

{# Top Announcement Bar (Above Header) #}
{% snipplet "header/top-banner.tpl" %}

<header class="js-head-main head-main {{ header_colors_classes }} {{ header_transparent_classes }} {{ head_transparent_color_class }} {{ head_transparent_logo_class }} {{ head_position_mobile }} {{ head_position_desktop }} {{ header_logo_mobile_classes }} {{ header_logo_mobile_search_icon_classes }} {{ header_logo_desktop_classes }} {{ header_logo_left_nav_below_desktop_classes }} {{ head_nav_inline_desktop_classes }} {{ head_desktop_nav_color_classes }} {{ head_languages_class }} {{ head_adbar_classes }} transition-soft" data-store="head">

    {# Secondary nav and account links #}

    {% snipplet "header/header-top.tpl" %}

    <div class="head-logo-row position-relative">
        <div class="container">
            <div class="{% if not settings.head_fix_desktop %}js-nav-logo-bar{% endif %} row no-gutters align-items-center">

                {# Menu icon #}

                <div class="col-auto col-utility d-md-none">
                    {% include "snipplets/header/header-utilities.tpl" with {use_menu: true} %}
                </div>

                {# Logo #}

                <div class="js-logo-container col {{ logo_mobile_classes }} {{ logo_desktop_classes }} {{ hamburger_icon_spacing_classes }}">
                    {% set logo_size_class = settings.logo_size == 'medium' ? 'logo-img-medium' : settings.logo_size == 'big' ? 'logo-img-big' %}
                    {{ component('logos/logo', {
                            logo_img_classes: 'transition-soft ' ~ logo_size_class,
                            logo_text_classes: 'h3 m-0',
                            logo_size: 'large'
                        })
                    }}
                    {% if template == 'home' and settings.head_transparent and settings.head_transparent_contrast_options and "logo-transparent.jpg" | has_custom_image %}
                        {{ component('logos/logo-transparent-header', {
                            container_classes: { logo_img_container: "logo-header-transparent-container"},
                            logo_img_name: 'logo-transparent.jpg',
                            logo_img_classes: 'transition-soft '  ~ logo_size_class,
                            logo_size: 'large'
                            })
                        }}
                    {% endif %}
                </div>

                {# Desktop navigation next to logo #}

                {% if settings.logo_position_desktop == 'left' and not settings.search_big_desktop %}
                    {# Desktop nav next logo #}
                    <div class="js-desktop-nav-col desktop-nav-col transition-soft col {{ show_inline_desktop_hide_mobile_class }} align-items-center pr-md-4">
                        {% snipplet "navigation/navigation.tpl" %}
                    </div>
                {% endif %}

                {# Search: Icon or box (desktop only) #}

                <div class="js-utility-col js-search-utility col-auto desktop-utility-col {{ search_col_md_classes }} col-utility d-none d-md-inline-block order-md-0">
                    {% if settings.search_big_desktop %}
                        <span class="{{ show_block_desktop_hide_mobile_class }}">
                            {% include "snipplets/header/header-search.tpl" %}
                        </span>
                    {% endif %}
                    {% if not settings.search_big_mobile or not settings.search_big_desktop %}
                        <span class="{{ search_icon_visibility_classes }} {% if settings.logo_position_desktop == 'left' %}float-md-right{% endif %}">
                            {% include "snipplets/header/header-utilities.tpl" with {use_search: true} %}
                        </span>
                    {% endif %}
                </div>

                {# Languages #}

                {% if has_languages %}
                    <div class="js-utility-col col-utility desktop-utility-col order-md-2">
                        {% include "snipplets/header/header-utilities.tpl" with {use_languages: true} %}
                    </div>
                {% endif %}

                {# Account icon #}
                
                <div class="js-utility-col col-utility desktop-utility-col text-right {{ show_inline_desktop_hide_mobile_class }} {{ account_icon_col_classes }}">
                    {% include "snipplets/header/header-utilities.tpl" with {use_account: true, icon_only: true} %}
                </div>

                {# Cart icon #}

                <div class="js-utility-col col-auto col-utility desktop-utility-col order-2">
                    {% include "snipplets/header/header-utilities.tpl" %}
                </div>

                {# Add to cart notification #}

                {% if settings.ajax_cart %}
                    {% if not settings.head_fix_desktop %}
                        <div class="{{ show_block_mobile_hide_desktop_class }}">
                    {% endif %}
                            {% include "snipplets/notification.tpl" with {add_to_cart: true} %}
                    {% if not settings.head_fix_desktop %}
                        </div>
                    {% endif %}
                {% endif %}

            </div>
        </div>
    </div>   

    {# Mobile search big (hidden to match requested mobile header layout) #}
    {% if false and settings.search_big_mobile %}
        <div class="js-big-search-mobile pb-3 container {{ show_block_mobile_hide_desktop_class }}">
            {% include "snipplets/header/header-search.tpl" %}
        </div>
    {% endif %}

    <style>
    @media (max-width: 767px) {
        .head-main {
            background-color: var(--header-background, #000000) !important;
        }
        .head-logo-row {
            padding: 8px 0 !important;
        }
        .head-logo-row .row {
            display: flex !important;
            align-items: center !important;
            justify-content: space-between !important;
            flex-wrap: nowrap !important;
        }
        .head-logo-row .js-logo-container {
            text-align: center !important;
            padding: 0 10px !important;
            flex: 1 1 auto !important;
        }
        .head-logo-row .logo-img {
            max-height: 36px !important;
            width: auto !important;
            object-fit: contain !important;
        }
        .head-logo-row .btn-utility {
            padding: 6px 8px !important;
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            color: var(--header-foreground, #ffffff) !important;
        }
        .head-logo-row .btn-utility .utilities-icon {
            font-size: 26px !important;
            width: 26px !important;
            height: 26px !important;
        }
        .js-big-search-mobile {
            display: none !important;
        }
        .cart-summary .badge {
            position: absolute;
            top: -1px;
            right: 1px;
            min-width: 14px;
            height: 14px;
            line-height: 14px;
            padding: 0 3px;
            font-size: 9px;
            font-weight: 700;
            background-color: var(--accent-color, #c0392b);
            color: #ffffff;
            border-radius: 7px;
        }
    }
    .section-adbar, .js-adbar {
        display: none !important;
    }
    </style>

    {% if settings.logo_position_desktop == 'center' or (settings.logo_position_desktop == 'left' and settings.search_big_desktop) %}

        {# Desktop navigation below logo #}
        <div class="head-nav transition-soft d-none d-md-block">
            <div class="container {% if settings.logo_position_desktop == 'center' %}text-center{% endif %}">
                {% snipplet "navigation/navigation.tpl" %}
            </div>
        </div>
    {% endif %}

    {# Advertising bar (desativado conforme solicitado) #}
    {#
    {% if settings.ad_bar and head_transparent %}
        {% snipplet "header/header-advertising.tpl" %}
    {% endif %}
    #}
 
</header>

{{ component('nubesdk-slot', { type: "after_header" }) }}

{# Follow order notification #}

{% include "snipplets/notification.tpl" with {order_notification: true} %}

{# Advertising bar (desativado conforme solicitado) #}
{#    
{% if settings.ad_bar and not head_transparent %}
    {% snipplet "header/header-advertising.tpl" %}
{% endif %}
#}

{# Show cookie validation message #}

{% include "snipplets/notification.tpl" with {show_cookie_banner: true} %}

{# Add to cart notification for non fixed header #}

{% if settings.ajax_cart and not settings.head_fix_desktop %}
    <div class="{{ show_block_desktop_hide_mobile_class }}">
        {% include "snipplets/notification.tpl" with {add_to_cart: true, add_to_cart_fixed: true} %}
    </div>
{% endif %}

{# Cross selling promotion notification on add to cart #}

{% embed "snipplets/modal.tpl" with {
    modal_id: 'js-cross-selling-modal',
    modal_class: 'bottom modal-bottom-sheet h-auto overflow-none modal-body-scrollable-auto',
    modal_header: true,
    modal_header_class: 'p-2 m-2 w-100',
    modal_position: 'bottom',
    modal_transition: 'slide',
    modal_footer: true,
    modal_width: 'centered-md m-0 p-0 modal-full-width modal-md-width-400px',
    modal_close_class: 'mr-3'
} %}
    {% block modal_head %}
        {{ '¡Descuento exclusivo!' | translate }}
    {% endblock %}

    {% block modal_body %}
        {# Promotion info and actions #}

        <div class="js-cross-selling-modal-body" style="display: none"></div>
    {% endblock %}
{% endembed %}

{% include "snipplets/header/header-modals.tpl" %}
