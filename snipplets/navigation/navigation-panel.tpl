<div class="nav-secondary row no-gutters pl-3 align-items-center" data-store="account-links">
    <div class="col">
        {% include "snipplets/header/header-utilities.tpl" with {use_account: true} %}
    </div>
    <div class="col-auto pr-0">
        <a class="js-modal-close modal-close">
            <svg class="icon-inline svg-icon-text"><use xlink:href="#times"/></svg>
        </a>
    </div>
</div>

<div class="nav-primary">
    <ul class="nav-list" data-store="navigation" data-component="menu">
        {% include 'snipplets/navigation/navigation-nav-list.tpl' with { 'hamburger' : true  } %}
    </ul>
</div>