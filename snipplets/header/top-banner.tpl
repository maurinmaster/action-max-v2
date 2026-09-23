{# /*============================================================================
  #Top Announcement Bar (Above Header)
==============================================================================*/ #}

{% set top_bar_show = settings.top_bar_announcement_show is defined ? settings.top_bar_announcement_show : 1 %}
{% set top_bar_text = settings.top_bar_announcement_text | default('Frete grátis no Sudeste acima de R$ 279 · 5% off no Pix · 6x sem juros') %}
{% set top_bar_bg = settings.top_bar_announcement_bg_color | default('#000000') %}
{% set top_bar_color = settings.top_bar_announcement_text_color | default('#FFFFFF') %}
{% set top_bar_url = settings.top_bar_announcement_url | default('') %}

{% if top_bar_show and top_bar_show != '0' and top_bar_text %}
    <style>
        .section-top-announcement-bar {
            width: 100%;
            position: relative;
            z-index: 101;
            padding: 7px 14px 8px;
            font-size: 13px;
            line-height: 1.35;
            font-weight: 500;
            letter-spacing: 0.2px;
            text-align: center;
            box-sizing: border-box;
            border-bottom: 1px solid rgba(255, 255, 255, 0.15);
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .section-top-announcement-bar .top-announcement-bar-content {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 18px;
        }
        .section-top-announcement-bar .top-announcement-bar-link {
            color: inherit;
            text-decoration: none;
            display: inline-block;
            transition: opacity 0.2s ease;
        }
        .section-top-announcement-bar .top-announcement-bar-link:hover {
            opacity: 0.85;
            text-decoration: none;
        }
        .section-top-announcement-bar .top-announcement-bar-text {
            display: inline-block;
        }
        @media (max-width: 767px) {
            .section-top-announcement-bar {
                padding: 6px 12px 8px;
                font-size: 12px;
                line-height: 1.35;
            }
        }
    </style>

    <div class="js-top-announcement-bar section-top-announcement-bar" style="background-color: {{ top_bar_bg }}; color: {{ top_bar_color }};">
        <div class="container">
            <div class="top-announcement-bar-content">
                {% if top_bar_url %}
                    <a href="{{ top_bar_url }}" class="top-announcement-bar-link" style="color: {{ top_bar_color }};">
                        {{ top_bar_text }}
                    </a>
                {% else %}
                    <span class="top-announcement-bar-text">
                        {{ top_bar_text }}
                    </span>
                {% endif %}
            </div>
        </div>
    </div>
{% endif %}
