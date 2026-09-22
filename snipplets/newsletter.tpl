{% set newsletter_contact_error = contact.type == 'newsletter' and not contact.success %}

{% set newsletter_title = home_newsletter ? settings.home_news_title : settings.news_title %}
{% set newsletter_text = home_newsletter ? settings.home_news_text : settings.news_text %}

{% set newsletter_form_class = not home_newsletter ? 'col-md-6' %}
{% set newsletter_input_container_classes = home_newsletter ? 'col' : 'col-md mb-3 mb-md-0' %}
{% set newsletter_btn_container_classes = home_newsletter ? 'col-auto pl-3' : 'col-md-auto' %}
{% set newsletter_btn_classes = home_newsletter ? 'btn-primary newsletter-btn' : 'btn-link px-4' %}

{% if (settings.news_show and not home_newsletter) or home_newsletter %}
    {% if not home_newsletter %}
        <div class="newsletter-footer">
            <div class="js-newsletter newsletter container py-4 overflow-none">
                <div class="row align-items-center text-center text-md-left my-3 my-md-2">
    {% endif %}
                    {% if home_newsletter %}
                        <div class="js-home-newsletter-title h1-md h2 mb-3" {% if not newsletter_title %}style="display: none"{% endif %}>{{ newsletter_title }}</div>
                    {% elseif settings.news_title %}
                        <div class="col-md mb-3 mb-md-0">
                            <div class="h1-md h2">{{ newsletter_title }}</div>
                        </div>
                    {% endif %}

                    {% if home_newsletter %}
                        <div class="js-home-newsletter-text mb-3" {% if not newsletter_text %}style="display: none"{% endif %}>{{ newsletter_text }}</div>
                    {% elseif settings.news_text %}
                        <div class="col-md mb-3 mb-md-0" >
                            <div class="font-small">{{ newsletter_text }}</div>
                        </div>
                    {% endif %}

                    <form class="{{ newsletter_form_class }}" method="post" action="/winnie-pooh" onsubmit="this.setAttribute('action', '');" data-store="{{ form_data_store }}">
                        <div class="newsletter-form input-append row no-gutters align-items-center">
                            <div class="{{ newsletter_input_container_classes }}">
                                {% embed "snipplets/forms/form-input.tpl" with{input_for: 'email', type_email: true, input_name: 'email', input_id: 'email', input_placeholder: 'Ingresá tu email...' | translate, input_group_custom_class: "mb-0", input_custom_class: '', input_aria_label: 'Email' | translate } %}
                                {% endembed %}
                            </div>
                            <div class="{{ newsletter_btn_container_classes }}">
                                <div class="winnie-pooh" style="display: none;">
                                    <label for="winnie-pooh-newsletter">{{ "No completar este campo" | translate }}</label>
                                    <input id="winnie-pooh-newsletter" type="text" name="winnie-pooh"/>
                                </div>
                                <input type="hidden" name="name" value="{{ "Sin nombre" | translate }}" />
                                <input type="hidden" name="message" value="{{ "Pedido de inscripción a newsletter" | translate }}" />
                                <input type="hidden" name="type" value="newsletter" />
                                <input type="submit" name="contact" class="btn {{ newsletter_btn_classes }}" value="{{ "Enviar" | translate }}" />
                            </div>
                        </div>
                        {% if contact and contact.type == 'newsletter' %}
                            {% if contact.success %}
                                <div class="alert alert-success mt-3 text-center">{{ "¡Gracias por suscribirte! A partir de ahora vas a recibir nuestras novedades en tu email" | translate }}</div>
                            {% else %}
                                <div class="alert alert-success mt-3 text-center">{{ "Necesitamos tu email para enviarte nuestras novedades." | translate }}</div>
                            {% endif %}
                        {% endif %}
                    </form>
     {% if not home_newsletter %}
                </div>
            </div>
        </div>
    {% endif %}
{% endif %}