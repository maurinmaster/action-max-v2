<div class="pt-md-3{% if not home_main_product %} px-md-3{% endif %}">

    {# Product name and breadcrumbs for product page #}

    {% if home_main_product %}
        {# Product name #}
        <h2 class="mb-3">{{ product.name }}</h2>
    {% else %}
        {% embed "snipplets/page-header.tpl" with {container: false, padding: false, page_header_title_class: 'js-product-name mb-3'} %}
            {% block page_header_text %}{{ product.name }}{% endblock page_header_text %}
        {% endembed %}
    {% endif %}

    {# Product SKU #}

    {% if settings.product_sku and product.sku %}
        <div class="font-small opacity-60 mb-3">
            {{ "SKU" | translate }}: <span class="js-product-sku">{{ product.sku }}</span>
        </div>
    {% endif %}

    {# Product price #}
    {% set is_subscription_only_product = product.isSubscribable() and product.isSubscriptionOnly() %}

    {% if not is_subscription_only_product %}
    <div class="price-container" data-store="product-price-{{ product.id }}">

        {{ component('nubesdk-slot', { type: "before_product_detail_price" }) }}

        <div class="js-price-container mb-3">
            <span class="d-inline-block mr-1">
            	<div class="js-price-display h3 font-huge" id="price_display" {% if not product.display_price %}style="display:none;"{% endif %} data-product-price="{{ product.price }}">{% if product.display_price %}{{ product.price | money }}{% endif %}</div>
            </span>
            {% include 'snipplets/labels.tpl' with {product_detail: true} %}
            {{ component('promotional-price-details', {
                promotional_price_details_classes: {
                    container: 'tooltip-container position-relative',
                    trigger: 'tooltip-trigger text-accent',
                    icon: 'icon-inline icon-lg icon-w-12',
                    detail_container: 'tooltip-card',
                    detail_row: 'd-flex justify-content-between align-items-center py-1 font-small',
                    detail_divider: 'divider mt-2 mb-2',
                    detail_total: 'font-weight-bold'
                },
                promotional_price_details_icon_svg_id: 'promotions',
            }) }}
            <span class="d-block font-big title-font-family mt-1">
               <div id="compare_price_display" class="js-compare-price-display price-compare {% if settings.payment_discount_price %}font-body{% endif %}" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% else %} style="display:block;"{% endif %}>{% if product.compare_at_price and product.display_price %}{{ product.compare_at_price | money }}{% endif %}</div>
            </span>
            {{ component('price-discount-disclaimer', {
                container_classes: 'font-small opacity-60 mt-2 mb-1',
            }) }}
            {{ component('price-without-taxes', {
                    container_classes: "mt-2 mb-1 pb-1 font-small opacity-60",
                })
            }}
            {{ component('payment-discount-price', {
                    visibility_condition: settings.payment_discount_price,
                    location: 'product',
                    container_classes: "h6 font-body font-weight-normal mt-2",
                    text_classes: {
                        price: 'h5 font-big text-accent font-weight-bold',
                    },
                })
            }}
        </div>

        {{ component('subscriptions/subscription-price', {
            location: 'product_detail',
            subscription_classes: {
                container: 'mb-3',
                prices_container: 'd-flex flex-wrap align-items-center mb-1',
                price_compare: 'font-big title-font-family mt-1 price-compare order-last w-100',
                price_with_subscription: 'h3 font-huge order-first mr-2',
                price_info: 'font-smallest',
                discount: 'label label-inline label-big',
                price_without_taxes_container: 'mt-2 mb-1 pb-1 font-small opacity-60',
            },
            subscription_discount_position: 'inline',
        }) }}

        {{ component('nubesdk-slot', { type: "after_product_detail_price" }) }}

        {% set installments_info = product.installments_info_from_any_variant %}
        {% set hasDiscount = product.maxPaymentDiscount.value > 0 %}
        {% set show_payments_info = settings.product_detail_installments and product.show_installments and product.display_price and installments_info %}
        {% set showDiscount = hasDiscount and product.showMaxPaymentDiscount %}
        {% set discountContainerStyle = not (showDiscount) ? "display: none" %}

        {{ component('nubesdk-slot', { type: "before_product_detail_payment_options" }) }}

        {% if not home_main_product and (show_payments_info or showDiscount) %}
            <div {% if installments_info %}data-toggle="#installments-modal" data-modal-url="modal-fullscreen-payments"{% endif %} class="{% if installments_info %}js-modal-open js-fullscreen-modal-open{% endif %} js-product-payments-container mb-3 {% if not home_main_product %}col-md-8{% endif %} px-0" {% if not product.display_price or not (product.get_max_installments and product.get_max_installments(false)) %}style="display: none;"{% endif %}>
        {% endif %}
        {% if show_payments_info %}
            {{ component('installments', {'location' : 'product_detail', container_classes: { installment: "mb-2 font-small"}}) }}
        {% endif %}
            <div class="js-product-discount-container mb-2 font-small" style="{{ discountContainerStyle }}">
                <span class="text-accent">{{ product.maxPaymentDiscount.value }}% {{'de descuento' | translate }}</span> {{'pagando con' | translate }} {{ product.maxPaymentDiscount.paymentProviderName }}
                {% set discountDisclaimerStyle = not product.showMaxPaymentDiscountNotCombinableDisclaimer ? "display: none" %}
                    <div class="js-product-discount-disclaimer font-small mt-1 opacity-60" style="{{ discountDisclaimerStyle }}">
                        {{ (product.showMaxPaymentDiscountCombinesWithSomeDiscounts
                            ? "No acumulable con algunas promociones"
                            : "No acumulable con otras promociones")
                        | translate }}
                    </div>
            </div>
        {% if not home_main_product and (show_payments_info or hasDiscount) %}
                <a id="btn-installments" class="font-small" href="#" {% if not (product.get_max_installments and product.get_max_installments(false)) %}style="display: none;"{% endif %}>
                    <svg class="icon-inline icon-lg svg-icon-text"><use xlink:href="#credit-card"/></svg>
                    {% if not hasDiscount and not settings.product_detail_installments %}
                        {{ "Ver medios de pago" | translate }}
                    {% else %}
                        {{ "Ver más detalles" | translate }}
                    {% endif %}
                </a>
            </div>
        {% endif %}

        {{ component('nubesdk-slot', { type: "after_product_detail_payment_options" }) }}

        {# Product availability #}

        {% set show_product_quantity = product.available and product.display_price %}

        {# Gift promotion message #}

        {{ component('gift-promotion-message', {
            gift_svg_id: 'gift',
            container_classes: {
                container: 'mb-4 font-small',
                icon: 'icon-inline svg-icon-accent icon-lg float-left mr-1',
                highlight: 'text-accent font-weight-normal',
            },
        }) }}

        {# Free shipping minimum message #}
        {% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}
        {% set has_product_free_shipping = product.free_shipping %}
        {% set shipping_best_discount = cart.free_shipping.min_price_free_shipping %}
        {% set is_full_free_shipping = shipping_best_discount.is_free or not shipping_best_discount.discount_type %}

        {% if not product.is_non_shippable and show_product_quantity and (has_free_shipping or has_product_free_shipping) %}
            <div class="js-free-shipping-minimum-message free-shipping-message mb-4">
                <span class="float-left mr-1">
                    <svg class="icon-inline svg-icon-accent icon-lg"><use xlink:href="#truck"/></svg>
                </span>
                <span class="font-small">
                    {% if has_product_free_shipping or is_full_free_shipping %}
                        {% set shipping_discount_label = "Envío gratis" | translate %}
                    {% else %}
                        {% set shipping_discount = shipping_best_discount.discount_type == 'percentage'
                            ? (shipping_best_discount.discount_value | round) ~ '%'
                            : shipping_best_discount.discount_value_money
                        %}
                        {% set shipping_discount_label = shipping_discount ~ ' ' ~ ('our_components.free_shipping_bar.off_shipping' | tt) %}
                    {% endif %}
                    <span class="text-accent">{{ shipping_discount_label }}</span>
                    <span {% if has_product_free_shipping %}style="display: none;"{% else %}class="js-shipping-minimum-label"{% endif %}>
                        {{ "superando los" | translate }} <span>{{ cart.free_shipping.min_price_free_shipping.min_price }}</span>
                    </span>
                </span>
                {% if not has_product_free_shipping %}
                    <div class="js-free-shipping-discount-not-combinable font-small opacity-60 mt-1">
                        {{ "No acumulable con otras promociones" | translate }}
                    </div>
                {% endif %}
            </div>
        {% endif %}
    </div>

    {% else %}
        {# Subscription only: show only subscription price #}

        {{ component('nubesdk-slot', { type: "before_product_detail_price" }) }}

        {{ component('subscriptions/subscription-price', {
            location: 'product_detail',
            subscription_classes: {
                container: 'mb-3',
                prices_container: 'd-flex flex-wrap align-items-center mb-1',
                price_compare: 'font-big title-font-family mt-1 price-compare order-last w-100',
                price_with_subscription: 'h3 font-huge order-first mr-2',
                price_info: 'font-smallest',
                discount: 'label label-inline label-big',
                price_without_taxes_container: 'mt-2 mb-1 pb-1 font-small opacity-60',
            },
            subscription_discount_position: 'inline',
        }) }}

        {{ component('nubesdk-slot', { type: "after_product_detail_price" }) }}

    {% endif %}

    {{ component('promotions-details', {
        promotions_details_classes: {
            container: 'js-product-promo-container px-0 mb-2' ~ (not home_main_product ? ' col-md-8' : ''),
            promotion_title: 'mb-2 mt-4 text-accent',
            valid_scopes: 'font-small mb-0',
            categories_combinable: 'font-small mb-0',
            not_combinable: 'font-small opacity-60 mb-0',
            progressive_discounts_table: 'table mb-2 mt-3',
            progressive_discounts_hidden_table: 'table-body-inverted',
            progressive_discounts_show_more_link: 'btn-link btn-link-primary mb-4',
            progressive_discounts_show_more_icon: 'icon-inline',
            progressive_discounts_hide_icon: 'icon-inline icon-flip-vertical',
            progressive_discounts_promotion_quantity: 'font-weight-light text-lowercase'
        },
        accordion_show_svg_id: 'chevron-down',
        accordion_hide_svg_id: 'chevron-down',
    }) }}

    {# Product form, includes: Variants, CTA and Shipping calculator #}

     <form id="product_form" class="js-product-form mt-4" method="post" action="{{ store.cart_url }}" data-store="product-form-{{ product.id }}">
        <input type="hidden" name="add_to_cart" value="{{product.id}}" />
        {% if template == "product" %}
            {% set show_size_guide = true %}
        {% endif %}
        {% if product.variations %}
            {% include "snipplets/product/product-variants.tpl" with {show_size_guide: show_size_guide} %}
        {% endif %}

        {% if settings.last_product and show_product_quantity %}
            <div class="{% if product.variations %}js-last-product{% endif %} text-accent mb-3"{% if product.selected_or_first_available_variant.stock != 1 %} style="display: none;"{% endif %}>
                {{ settings.last_product_text }}
            </div>
        {% endif %}

        {# Kit products: components list, with variant selector when the kit component has variants #}

        {% set is_kit = product.is_kit %}

        {{ component('kit-products', {
            show_variant_selector: true,
            use_bullet_variants: settings.bullet_variants,
            use_image_color_variants: settings.image_color_variants,
            select_icon_svg_id: 'chevron-down',
            kit_products_classes: {
                container: 'mb-4',
                list: 'list-unstyled mb-0',
                item_wrap: 'top-line',
                item: 'd-flex align-items-center py-3',
                image_wrap: 'flex-shrink-0 mr-3',
                image: 'kit-products-item-image',
                text: 'flex-grow-1 min-w-0',
                quantity: 'font-small opacity-60',
                name: 'font-small font-weight-normal mb-0',
                variants: {
                    container: 'kit-product-variants mt-2',
                    group: 'form-group mb-3',
                    select_wrap: 'form-group mb-0',
                    label: 'form-label',
                    select: 'form-select',
                    select_icon: 'form-select-icon',
                    select_icon_svg: 'icon-inline icon-w-14',
                    swatch: 'btn btn-variant mb-0',
                    swatch_color: 'btn-variant-color',
                    swatch_selected: 'selected',
                    swatch_content: 'btn-variant-content',
                    swatch_content_image: 'btn-variant-content-square',
                    swatch_image: 'img-absolute-centered-vertically',
                },
            },
        }) }}

        {% if is_kit %}
            <input type="hidden" name="kit_selections" class="js-kit-selections" value="">
        {% endif %}

        {{ component('nubesdk-slot', { type: "before_product_detail_add_to_cart" }) }}

        <div class="row no-gutters mb-4 {% if settings.product_stock %}mb-md-3{% endif %}">
            {% set product_quantity_home_product_value = home_main_product ? true : false %}
            {% if show_product_quantity %}
                {% include "snipplets/product/product-quantity.tpl" with {home_main_product: product_quantity_home_product_value} %}
            {% endif %}

            {{ component('subscriptions/subscription-selector', {
                subscription_classes: {
                    container: 'radio-button-container my-2',
                    subscription_only_container: 'p-3',

                    radio_button: 'radio-button-item card p-3 mb-2 overflow-visible',
                    radio_button_label: 'ml-1',
                    radio_button_text: 'row',
                    radio_button_icon: 'radio-button-icons',
                    purchase_option_info_container: 'col-auto font-small pr-0',
                    purchase_option_price: 'col text-right font-weight-bold',
                    purchase_option_price_info: 'font-smallest',
                    purchase_option_single_frequency: 'mt-2 pt-1 font-small opacity-80',
                    purchase_option_discount: 'label label-accent label-small ml-1',

                    dropdown_container: 'form-group mt-3 mb-0 p-0 background-main ' ~ (not home_main_product ? 'col-md-9'),
                    dropdown_button: 'form-select p-2',
                    dropdown_icon: 'form-select-icon icon-inline icon-w-14 icon-lg',
                    dropdown_options: 'form-select-options',
                    dropdown_option: 'form-select-option row no-gutters',
                    dropdown_option_info: 'col pr-4',
                    dropdown_option_price: 'col-auto text-right font-weight-bold',
                    dropdown_option_price_info: 'font-smallest',
                    dropdown_option_discount: 'text-accent mt-1 font-weight-bold',
                    dropdown_option_frequency_info: 'font-small mt-1',

                    shipping_message_icon: 'icon-inline icon-lg svg-icon-text mr-1',
                    shipping_message: 'mb-3 pt-1',
                    shipping_message_text: 'font-small mt-1 ml-4 pl-1'
                },
                allow_subscription_only: is_subscription_only_product,
                dropdown_icon: true,
                dropdown_icon_svg_id: 'chevron-down',

                shipping_message_icon: true,
                shipping_message_icon_svg_id: 'truck',
            }) }}
            
            {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
            {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}

            {% set btn_container_classes = show_product_quantity and not product.isSubscribable() ? 'col-8 ' ~ (not home_main_product ? 'col-md-9' : '') : 'col-12' %}
            
            <div class="{{ btn_container_classes }} {% if product.isSubscribable() %}mt-2{% endif %}">

                {# Add to cart CTA #}

                <input type="submit"
                    class="js-addtocart js-prod-submit-form btn-add-to-cart btn btn-primary btn-big w-100 {{ state }}"
                    value="{{ texts[state] | translate }}"
                    {% if state == 'nostock' %}disabled{% endif %}
                    {% if is_kit and not store.is_catalog %}
                        data-kit-label-buyable="{{ texts[state == 'contact' ? 'contact' : 'cart'] | translate }}"
                        data-kit-class-buyable="{{ state == 'contact' ? 'contact' : 'cart' }}"
                        data-kit-label-nostock="{{ texts.nostock | translate }}"
                        data-contact-label="{{ texts.contact | translate }}"
                    {% endif %}
                    data-store="product-buy-button"
                    data-component="product.add-to-cart"
                />

                {# Fake add to cart CTA visible during add to cart event #}

                {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "btn-big w-100"} %}

            </div>

            {% if settings.ajax_cart %}
                <div class="col-12">
                    <div class="js-added-to-cart-product-message font-small my-3" style="display: none;">
                        <svg class="icon-inline icon-lg svg-icon-text"><use xlink:href="#check"/></svg>
                        <span>
                            {{'Ya agregaste este producto.' | translate }}<a href="#" class="js-modal-open js-open-cart js-fullscreen-modal-open btn-link font-small ml-1" data-toggle="#modal-cart" data-modal-url="modal-fullscreen-cart">{{ 'Ver carrito' | translate }}</a>
                        </span>
                    </div>
                </div>
            {% endif %}

            {# Free shipping visibility message #}

            {% set free_shipping_minimum_label_changes_visibility = has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

            {% set include_product_free_shipping_min_wording = cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

            {% if not product.is_non_shippable and show_product_quantity and has_free_shipping and not has_product_free_shipping and is_full_free_shipping %}

                {# Free shipping add to cart message #}

                {% if include_product_free_shipping_min_wording %}

                    {% include "snipplets/shipping/shipping-free-rest.tpl" with {'product_detail': true} %}

                {% endif %}

                {# Free shipping achieved message #}

                <div class="js-product-form-free-shipping-message {% if free_shipping_minimum_label_changes_visibility %}js-free-shipping-message{% endif %} text-accent font-weight-bold my-2 pt-1 h6 font-body" {% if not cart.free_shipping.cart_has_free_shipping %}style="display: none;"{% endif %}>
                    {{ "¡Genial! Tenés envío gratis" | translate }}
                </div>

            {% endif %}
        </div>

        {{ component('nubesdk-slot', { type: "after_product_detail_add_to_cart" }) }}

        {% if template == 'product' %}

            {% set show_product_fulfillment = settings.shipping_calculator_product_page and (store.has_shipping or store.branches) and not product.free_shipping and not product.is_non_shippable %}

            {{ component('nubesdk-slot', { type: "before_product_detail_shipping_options" }) }}

            {% if show_product_fulfillment %}
                <div class="mb-4 pb-2">
                    {# Shipping calculator and branch link #}

                    <div id="product-shipping-container" class="product-shipping-calculator list" {% if not product.display_price or not product.has_stock %}style="display:none;"{% endif %} data-shipping-url="{{ store.shipping_calculator_url }}">
                        {% if store.has_shipping %}
                            {% include "snipplets/shipping/shipping-calculator.tpl" with {'shipping_calculator_variant' : product.selected_or_first_available_variant, 'product_detail': true} %}
                        {% endif %}
                    </div>

                    {% if store.branches %}
                        {# Link for branches #}
                        {% include "snipplets/shipping/branches.tpl" with {'product_detail': true} %}
                    {% endif %}
                </div>

            {% endif %}

            {{ component('nubesdk-slot', { type: "after_product_detail_shipping_options" }) }}

        {% endif %}
     </form>
</div>

{% if not home_main_product %}
   {# Product payments details #}
    {% include 'snipplets/product/product-payment-details.tpl' %}
{% endif %}
