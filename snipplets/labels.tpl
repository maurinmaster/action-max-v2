{% set label_accent_classes = 'label label-inline ' %}

{% set inline_product_detail_label = not labels_floating and product_detail %}

{# Prioritize custom promotion label when is not percentage off for product detail #}
{% set custom_label = product.getPromotionCustomLabel %}
{% set has_custom_promotion_label = custom_label and custom_label | trim %}

{{ component(
  'labels', {
    defer_stock_label_text: true,
    prioritize_promotion_over_offer: product_detail ? false : true,
    promotion_nxm_long_wording: false,
    promotion_quantity_long_wording: true,
    free_shipping_and_no_stock_only: labels_floating ? true : false,
    offer_only: inline_product_detail_label and not has_custom_promotion_label ? true : false,
    promotion_only: inline_product_detail_label and has_custom_promotion_label ? true : false,
    promotion_and_offer_only: not labels_floating and not product_detail ? true : false,
    offer_negative_discount_percentage: not labels_floating ? true : false,
    group_data_store: labels_floating ? false : true,
    labels_classes: {
      group: (labels_floating ? 'js-labels-floating-group labels-absolute' : 'd-inline-block align-text-top'),
      promotion: label_accent_classes  ~ (product_detail ? 'label-big'),
      promotion_secondary_text: 'text-lowercase',
      offer: 'js-offer-label ' ~ label_accent_classes ~ (product_detail ? 'label-big'),
      shipping: 'label label-accent ' ~ (product_detail ? 'label-big'),
      no_stock: 'js-stock-label label label-default ' ~ (product_detail ? 'label-big'),
    },
  })
}}