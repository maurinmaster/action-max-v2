{# /*============================================================================
  #Home Routine Module (Sua rotina, do acordar ao deitar)
==============================================================================*/ #}

{% set routine_show = settings.routine_show is defined ? settings.routine_show : 1 %}
{% set routine_title = settings.routine_title | default('SUA ROTINA, DO ACORDAR AO DEITAR') %}
{% set routine_subtitle = settings.routine_subtitle | default('Escolha pelo momento do seu dia.') %}
{% set routine_bg = settings.routine_background_color | default('#FFFFFF') %}

{% if routine_show and routine_show != '0' %}
<section class="section-home section-routine py-4 py-md-5" data-store="home-routine" style="background-color: {{ routine_bg }};">
    <div class="container">
        <div class="routine-header mb-3 mb-md-4">
            {% if routine_title %}
                <h2 class="routine-main-title">{{ routine_title }}</h2>
            {% endif %}
            {% if routine_subtitle %}
                <p class="routine-sub-title">{{ routine_subtitle }}</p>
            {% endif %}
        </div>

        <div class="routine-grid">
            {% for i in 1..4 %}
                {% set card_title = attribute(settings, 'routine_card_0' ~ i ~ '_title') %}
                {% set card_product = attribute(settings, 'routine_card_0' ~ i ~ '_product') %}
                {% set card_url = attribute(settings, 'routine_card_0' ~ i ~ '_url') %}
                {% set card_icon = attribute(settings, 'routine_card_0' ~ i ~ '_icon') %}

                {# Fallbacks matching reference image #}
                {% if i == 1 %}
                    {% set card_title = card_title | default('Manhã') %}
                    {% set card_product = card_product | default('Shot Be Imune') %}
                    {% set card_icon = card_icon | default('sun') %}
                {% elseif i == 2 %}
                    {% set card_title = card_title | default('Treino') %}
                    {% set card_product = card_product | default('[produto oficial]') %}
                    {% set card_icon = card_icon | default('dumbbell') %}
                {% elseif i == 3 %}
                    {% set card_title = card_title | default('Dia a dia') %}
                    {% set card_product = card_product | default('[produto oficial]') %}
                    {% set card_icon = card_icon | default('briefcase') %}
                {% elseif i == 4 %}
                    {% set card_title = card_title | default('Noite') %}
                    {% set card_product = card_product | default('[produto oficial]') %}
                    {% set card_icon = card_icon | default('moon') %}
                {% endif %}

                {% set tag_name = card_url ? 'a' : 'div' %}
                <{{ tag_name }} {% if card_url %}href="{{ card_url }}"{% endif %} class="routine-card">
                    <div class="routine-card-icon">
                        {% if card_icon == 'sun' %}
                            <svg viewBox="0 0 24 24" width="28" height="28" stroke="currentColor" stroke-width="1.8" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="12" cy="12" r="4"></circle>
                                <line x1="12" y1="2" x2="12" y2="4"></line>
                                <line x1="12" y1="20" x2="12" y2="22"></line>
                                <line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line>
                                <line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line>
                                <line x1="2" y1="12" x2="4" y2="12"></line>
                                <line x1="20" y1="12" x2="22" y2="12"></line>
                                <line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line>
                                <line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line>
                            </svg>
                        {% elseif card_icon == 'dumbbell' %}
                            <svg viewBox="0 0 24 24" width="28" height="28" stroke="currentColor" stroke-width="1.8" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M6 5v14M18 5v14M3 8v8M21 8v8M6 12h12M1 10v4M23 10v4"></path>
                            </svg>
                        {% elseif card_icon == 'briefcase' %}
                            <svg viewBox="0 0 24 24" width="28" height="28" stroke="currentColor" stroke-width="1.8" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect>
                                <path d="M16 7V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v2"></path>
                            </svg>
                        {% elseif card_icon == 'moon' %}
                            <svg viewBox="0 0 24 24" width="28" height="28" stroke="currentColor" stroke-width="1.8" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path>
                            </svg>
                        {% elseif card_icon == 'zap' %}
                            <svg viewBox="0 0 24 24" width="28" height="28" stroke="currentColor" stroke-width="1.8" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon>
                            </svg>
                        {% elseif card_icon == 'heart' %}
                            <svg viewBox="0 0 24 24" width="28" height="28" stroke="currentColor" stroke-width="1.8" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        {% elseif card_icon == 'coffee' %}
                            <svg viewBox="0 0 24 24" width="28" height="28" stroke="currentColor" stroke-width="1.8" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M18 8h1a4 4 0 0 1 0 8h-1M2 8h16v9a4 4 0 0 1-4 4H6a4 4 0 0 1-4-4V8zM6 1v3M10 1v3M14 1v3"></path>
                            </svg>
                        {% else %}
                            <svg viewBox="0 0 24 24" width="28" height="28" stroke="currentColor" stroke-width="1.8" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="12" cy="12" r="10"></circle>
                                <polyline points="12 6 12 12 16 14"></polyline>
                            </svg>
                        {% endif %}
                    </div>
                    <div class="routine-card-title">{{ card_title }}</div>
                    {% if card_product %}
                        <div class="routine-card-product">{{ card_product }}</div>
                    {% endif %}
                </{{ tag_name }}>
            {% endfor %}
        </div>
    </div>
</section>

<style>
.section-routine {
    width: 100%;
    box-sizing: border-box;
}
.routine-header {
    text-align: left;
}
.routine-main-title {
    font-size: 20px;
    font-weight: 800;
    line-height: 1.25;
    letter-spacing: -0.3px;
    color: var(--main-foreground, #0f172a);
    margin: 0 0 6px 0;
    text-transform: uppercase;
}
.routine-sub-title {
    font-size: 14px;
    color: #64748b;
    margin: 0;
    font-weight: 400;
    line-height: 1.4;
}
.routine-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 12px;
}
@media (min-width: 768px) {
    .routine-main-title {
        font-size: 26px;
    }
    .routine-sub-title {
        font-size: 15px;
    }
    .routine-grid {
        grid-template-columns: repeat(4, 1fr);
        gap: 18px;
    }
}
.routine-card {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    background-color: #ffffff;
    border: 1px solid #e2e8f0;
    border-radius: 16px;
    padding: 18px 14px;
    text-decoration: none !important;
    color: inherit;
    box-sizing: border-box;
    cursor: pointer;
    transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.02);
}
.routine-card:hover {
    border-color: #0f172a;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.06);
    transform: translateY(-2px);
}
.routine-card-icon {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 32px;
    height: 32px;
    margin-bottom: 12px;
    color: #1e293b;
}
.routine-card-title {
    font-size: 16px;
    font-weight: 700;
    line-height: 1.25;
    color: #0f172a;
    margin-bottom: 4px;
}
.routine-card-product {
    font-size: 13px;
    font-weight: 400;
    color: #64748b;
    line-height: 1.35;
    width: 100%;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
.routine-card:hover .routine-card-product {
    color: #0f172a;
}
</style>
{% endif %}
