window.tiendaNubeInstaTheme = (function(jQueryNuvem) {
	return {
		waitFor: function() {
			return [];
		},
		placeholders: function() {
			return [
				{
					placeholder: '.js-home-slider-placeholder',
					content: '.js-home-slider-top',
					contentReady: function() {
						return $(this).find('img').length > 0;
					},
				},
				{
					placeholder: '.js-category-banner-placeholder',
					content: '.js-category-banner-top',
					contentReady: function() {
						return $(this).find('img').length > 0;
					},
				},
				{
					placeholder: '.js-promotional-banner-placeholder',
					content: '.js-promotional-banner-top',
					contentReady: function() {
						return $(this).find('img').length > 0;
					},
				},
				{
					placeholder: '.js-news-banner-placeholder',
					content: '.js-news-banner-top',
					contentReady: function() {
						return $(this).find('img').length > 0;
					},
				},
				{
					placeholder: '.js-module-banner-placeholder',
					content: '.js-module-banner-top',
					contentReady: function() {
						return $(this).find('img').length > 0;
					},
				},
			];
		},
		handlers: function(instaElements) {
			const handlers = {
				logo: new instaElements.Logo({
					$storeName: jQueryNuvem('#no-logo'),
					$logo: jQueryNuvem('#logo')
				}),
				// ----- Section order -----
				home_order_position: new instaElements.Sections({
					container: '.js-home-sections-container',
					data_store: {
						'slider': 'home-slider',
						'main_categories': 'home-categories-featured',
						'products': 'home-products-featured',
						'welcome': 'home-welcome-message',
						'institutional': 'home-institutional-message',
						'informatives': 'banner-services',
						'categories': 'home-banner-categories',
						'promotional': 'home-banner-promotional',
						'news_banners': 'home-banner-news',
						'new': 'home-products-new',
						'video': 'home-video',
						'sale': 'home-products-sale',
						'promotion': 'home-products-promotion',
						'best_seller': 'home-products-best-seller',
						'instafeed': 'home-instagram-feed',
						'main_product': 'home-product-main',
						'brands': 'home-brands',
						'testimonials': 'home-testimonials',
						'newsletter' : 'home-newsletter',
						'modules': 'home-image-text-module',
					}
				}),
			};

			// ----------------------------------- Highlighted Products -----------------------------------

			// Same logic applies to all 5 types of highlighted products

			['featured', 'new', 'sale', 'promotion', 'best_seller'].forEach(setting => {
				
				let settingSelector = setting;
				if (setting === 'best_seller') {
					settingSelector = 'best-seller';
				}
				const $productContainer = $(`.js-products-${settingSelector}-container`);
				const $productContainerCol = $(`.js-products-${settingSelector}-col`);
				const $productGrid = $(`.js-products-${settingSelector}-grid`);

				const productSwiper = 
					setting == 'featured' ? 'productsFeaturedSwiper' : 
					setting == 'new' ? 'productsNewSwiper' : 
					setting == 'sale' ? 'productsSaleSwiper' :
					setting == 'promotion' ? 'productsPromotionSwiper' :
					setting == 'best_seller' ? 'productsBestSellerSwiper' :
					null;

				const $productItem = $productGrid.find(`.js-item-product`);

				// Updates title text
				handlers[`${setting}_products_title`] = new instaElements.Text({
					element: `.js-products-${settingSelector}-title`,
					show: function(){
						$(this).show();
					},
					hide: function(){
						$(this).hide();
					},
				})

				// Updates quantity products desktop
				handlers[`${setting}_products_desktop`] = new instaElements.Lambda(function(desktopProductQuantity){
					if (window.innerWidth > 768) {
						const productFormat = $productGrid.attr('data-desktop-format');
						$productItem.removeClass('col-md-2 col-md-2-4 col-md-3 col-md-4 col-md-6');
						$productGrid.attr('data-desktop-columns', desktopProductQuantity);
						if (desktopProductQuantity == 6) {
							$productItem.addClass('col-md-2');
						} else if (desktopProductQuantity == 5) {
							$productItem.addClass('col-md-2-4');
						} else if (desktopProductQuantity == 4) {
							$productItem.addClass('col-md-3');
						} else if (desktopProductQuantity == 3) {
							$productItem.addClass('col-md-4');
						} else if (desktopProductQuantity == 2) {
							$productItem.addClass('col-md-6');
						}
						if (productFormat == 'slider') {
							window[productSwiper].params.slidesPerView = desktopProductQuantity;
							window[productSwiper].update();
						}
					}
				});

				// Updates quantity products mobile
				handlers[`${setting}_products_mobile`] = new instaElements.Lambda(function(mobileProductQuantity){
					if (window.innerWidth < 768) {
						$productItem.removeClass('col-6 col-12');
						const productFormat = $productGrid.attr('data-mobile-format');
						const mobileProductSliderQuantity = mobileProductQuantity == '2' ? '2.25' : '1.15';
						$productGrid.attr('data-mobile-columns', mobileProductQuantity);
						$productGrid.attr('data-mobile-slider-columns', mobileProductSliderQuantity);
						if (mobileProductQuantity == 1) {
							$productItem.addClass('col-12');
						} else if (mobileProductQuantity == 2) {
							$productItem.addClass('col-6');
						}
						if (productFormat == 'slider') {
							window[productSwiper].params.slidesPerView = mobileProductSliderQuantity;
							window[productSwiper].update();
						}
					}
				});

				// Initialize swiper function
				function initSwiperElements() {
					const desktopProductQuantity = $productGrid.attr('data-desktop-columns');
					const mobileProductQuantity = $productGrid.attr('data-mobile-slider-columns');

					// Reset swiper before modifying DOM
					resetSwiperElements();

					// Wrap everything inside a swiper container

					$productGrid.addClass('swiper-wrapper swiper-products-slider flex-nowrap ml-md-0').removeClass("flex-wrap flex-md-wrap");

					$productGrid.wrapAll(`<div class="js-swiper-${settingSelector} swiper-container"></div>`);

					// Wrap each product into a slide
					$productItem.addClass("js-item-slide swiper-slide");

					const $swiperContainer = $(`.js-swiper-${settingSelector}`);

					$productContainerCol.addClass("pr-0 pr-md-3");

					if (window.innerWidth > 768) {
						// Add previous and next controls
						$swiperContainer.after(`
							<div class="js-swiper-${settingSelector}-prev swiper-button-prev swiper-button-outside d-none d-md-block svg-icon-text">
								<svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
							</div>
							<div class="js-swiper-${settingSelector}-next swiper-button-next swiper-button-outside d-none d-md-block svg-icon-text">
								<svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
							</div>
						`);
					}

					// Initialize swiper
					createSwiper(`.js-swiper-${settingSelector}`, {
						lazy: true,
						watchOverflow: true,
						centerInsufficientSlides: true,
						threshold: 5,
						watchSlideProgress: true,
						watchSlidesVisibility: true,
						slideVisibleClass: 'js-swiper-slide-visible',
						spaceBetween: 15,
						loop: $productItem.length > 4,
						navigation: {
							nextEl: `.js-swiper-${settingSelector}-next`,
							prevEl: `.js-swiper-${settingSelector}-prev`
						},
						slidesPerView: mobileProductQuantity,
						breakpoints: {
							768: {
								slidesPerView: desktopProductQuantity,
							}
						},
					},
					function(swiperInstance) {
						window[productSwiper] = swiperInstance;
					});

				}

				// Reset swiper function
				function resetSwiperElements() {

					const $swiperContainer = $(`.js-swiper-${settingSelector}`);
					
					if($swiperContainer.length){

						const desktopProductQuantity = $productGrid.attr('data-desktop-columns');
						const mobileProductQuantity = $productGrid.attr('data-mobile-columns');

						// Remove duplicate slides and slider controls
						$productContainer.find(`.js-swiper-${settingSelector}-prev`).remove();
						$productContainer.find(`.js-swiper-${settingSelector}-next`).remove();
						$productGrid.find('.swiper-slide-duplicate').remove();
						$productContainerCol.removeClass("pr-0 pr-md-3");

						// Undo all slider wrappers and restore original classes
						$productGrid.unwrap();
						$productGrid.removeClass("swiper-wrapper swiper-mobile-only swiper-desktop-only flex-nowrap flex-md-nowrap swiper-products-slider ml-md-0").addClass("flex-wrap").removeAttr('style');
						$productItem.removeClass('js-item-slide js-swiper-slide-visible swiper-slide-active swiper-slide').removeAttr('style');

						if (desktopProductQuantity == 6) {
							$productItem.addClass('col-md-2');
						} else if (desktopProductQuantity == 5) {
							$productItem.addClass('col-md-2-4');
						} else if (desktopProductQuantity == 4) {
							$productItem.addClass('col-md-3');
						} else if (desktopProductQuantity == 3) {
							$productItem.addClass('col-md-4');
						} else if (desktopProductQuantity == 2) {
							$productItem.addClass('col-md-6');
						}

						if (mobileProductQuantity == 1) {
							$productItem.addClass('col-12');
						} else if (mobileProductQuantity == 2) {
							$productItem.addClass('col-6');
						}
					}
				}

				// Toggle grid and slider mobile view
				handlers[`${setting}_products_format_mobile`] = new instaElements.Lambda(function(format){
					const toSlider = format == "slider";

					const mobileFormat = $productGrid.attr('data-mobile-format');
					const desktopFormat = $productGrid.attr('data-desktop-format');

					const desktopColumns = $productGrid.attr('data-desktop-columns');
					const mobileColumns = $productGrid.attr('data-slider-columns');
					
					if ($productGrid.attr('data-mobile-format') == format) {
						// Nothing to do
						return;
					}

					// From grid to slider
					if (toSlider) {
						$productGrid.attr('data-mobile-format', 'slider');

						// Convert grid to slider if it's not yet
						if (window.innerWidth < 768) {
							initSwiperElements();
						}

					// From slider to grid
					} else {
						$productGrid.attr('data-mobile-format', 'grid');
						if (window.innerWidth < 768) {
							resetSwiperElements();
							$productGrid.removeClass("swiper-products-slider ml-md-0");
						}
					}

					// Persist new format in data attribute
					$productGrid.attr('data-mobile-format', format);
				});

				// Toggle grid and slider desktop view
				handlers[`${setting}_products_format_desktop`] = new instaElements.Lambda(function(format){

					const toSlider = format == "slider";

					if ($productGrid.attr('data-desktop-format') == format) {
						// Nothing to do
						return;
					}

					// From grid to slider
					if (toSlider) {

						$productGrid.attr('data-desktop-format', 'slider');

						// Convert grid to slider if it's not yet
						if (window.innerWidth > 768) {
							initSwiperElements();
						}

					// From slider to grid
					} else {
						$productGrid.attr('data-desktop-format', 'grid');

						if (window.innerWidth > 768) {
							resetSwiperElements();
						}
					}

					// Persist new format in data attribute
					$productGrid.attr('data-desktop-format', format);
				});

				// Updates section colors
				handlers[`${setting}_product_colors`] = new instaElements.Lambda(function(sectionColor){
					const $container = $(`.js-section-products-${settingSelector}`);
					if (sectionColor) {
						$container.addClass(`section-${settingSelector}-products-home-colors section-home-color`);
					} else {
						$container.removeClass(`section-${settingSelector}-products-home-colors section-home-color`);
					}
				});
			});

			// ----------------------------------- Slider -----------------------------------

			// Build the html for a slide given the data from the settings editor
			function buildHomeSlideDom(aSlide, alignClasses, imageClasses) {
				return '<div class="swiper-slide slide-container swiper-' + aSlide.color + '">' +
							(aSlide.link ? '<a href="' + aSlide.link + '">' : '' ) +
								'<div class="slider-slide">' +
									'<img src="' + aSlide.src + '" class="js-slider-image slider-image ' + imageClasses + '"/>' +
									'<div class="js-swiper-text swiper-text ' + alignClasses + ' swiper-text-' + aSlide.color + '">' +
										(aSlide.description ? '<p class="mb-3">' + aSlide.description + '</p>' : '' ) +
										(aSlide.title ? '<div class="h1-huge mb-3">' + aSlide.title + '</div>' : '' ) +
										(aSlide.button && aSlide.link ? '<div class="btn btn-default btn-small d-inline-block">' + aSlide.button + '</div>' : '' ) +
									'</div>' +
								'</div>' +
							(aSlide.link ? '</a>' : '' ) +
						'</div>'
			}

			// Update slider align
			handlers.slider_align = new instaElements.Lambda(function(sliderAlign){
				const $swiperText = $('.js-home-slider-section').find('.js-swiper-text');
				const $homeSlider = $('.js-home-slider, .js-home-slider-mobile');

				if (sliderAlign == 'left') {
					$homeSlider.attr('data-align', 'left');
					$swiperText.removeClass('swiper-text-centered');
				} else {
					$homeSlider.attr('data-align', 'center');
					$swiperText.addClass('swiper-text-centered');
				}
			});

			// Update slider animation
			handlers.slider_animation = new instaElements.Lambda(function(sliderAnimation){
				const $swiperText = $('.js-home-slider-section').find('.js-slider-image');
				const $homeSlider = $('.js-home-slider, .js-home-slider-mobile');

				if (sliderAnimation) {
					$homeSlider.attr('data-animation', 'true');
					$swiperText.addClass('slider-image-animation');
				} else {
					$homeSlider.attr('data-animation', 'false');
					$swiperText.removeClass('slider-image-animation');
				}
			});

			// Update main slider
			handlers.slider = new instaElements.Lambda(function(slides){
				if (!window.homeSwiper) {
					return;
				}

				// Update align classes
				const sliderAlign = $('.js-home-slider').attr('data-align');
				const alignClasses = sliderAlign == 'center' ? 'swiper-text-centered' : '';

				// Update animation classes
				const sliderAnimation = $('.js-home-slider').attr('data-animation');
				const imageClasses = sliderAnimation == 'true' ? 'slider-image-animation' : '';

				window.homeSwiper.removeAllSlides();
				slides.forEach(function(aSlide){
					window.homeSwiper.appendSlide(buildHomeSlideDom(aSlide, alignClasses, imageClasses));
				});
				window.homeSwiper.update();
			});

			// Update mobile slider
			handlers.slider_mobile = new instaElements.Lambda(function(slides){
				// This slider is not included in the html if `toggle_slider_mobile` is not set.
				// The second condition could be removed if live preview for this checkbox is implemented but changing the viewport size forces a refresh, so it's not really necessary.
				if (!window.homeMobileSwiper || !window.homeMobileSwiper.slides) {
					return;
				}

				// Update align classes
				const sliderAlign = $('.js-home-slider-mobile').attr('data-align');
				const alignClasses = sliderAlign == 'center' ? 'swiper-text-centered' : '';

				// Update animation classes
				const sliderAnimation = $('.js-home-slider-mobile').attr('data-animation');
				const imageClasses = sliderAnimation == 'true' ? 'slider-image-animation' : '';

				window.homeMobileSwiper.removeAllSlides();
				slides.forEach(function(aSlide){
					window.homeMobileSwiper.appendSlide(buildHomeSlideDom(aSlide, alignClasses, imageClasses));
				});
				window.homeMobileSwiper.update();
			});

			// Update slider full
			handlers.slider_full = new instaElements.Lambda(function(sliderFull){
				const $mainSection = $('.js-main-slider-section');
				const $section = $('.js-home-slider-section');
				const $container = $('.js-home-slider-container');

				if (sliderFull) {
					$mainSection.removeClass('section-home');
					$container.removeClass('container').addClass('container-fluid p-0');
					if ($container.length == 0) {
						$section.removeClass('container');
					}

					// Updates slider width to avoids swipes inconsistency
					window.homeSwiper.params.observer = true;
					window.homeSwiper.update();

				} else {
					$mainSection.addClass('section-home');
					$container.removeClass('container-fluid p-0').addClass('container');
					if ($container.length == 0) {
						$section.addClass('container');
					}

					// Updates slider width to avoids swipes inconsistency
					window.homeSwiper.params.observer = true;
					window.homeSwiper.update();
				}

			});

			// ----------------------------------- Main Banners -----------------------------------

			// Build the html for a slide given the data from the settings editor

			var slideCount = 0;

			function buildHomeBannerDom(aSlide, bannerClasses, textBannerClasses, columnClasses, textClasses, imageContainerClasses, imageClasses, bannerModule) {
				slideCount++;
				var evenClass = slideCount % 2 === 0 ? 'js-banner-even order-md-first ' : '';
				return '<div class="js-banner col-grid ' + bannerClasses + (bannerModule ? ' col-12 ' : ' ') + ' ' + columnClasses + '">' +
						'<div class="js-textbanner textbanner ' + (bannerModule ? 'mb-md-5 pb-md-3 ' : ' ') + textBannerClasses + '">' +
							(aSlide.link ? '<a href="' + aSlide.link + '">' : '' ) +
								(bannerModule ? '<div class="row no-gutters align-items-center">' : '' ) +
									'<div class="js-textbanner-image-container textbanner-image overflow-none ' + (bannerModule ? 'col-md-6 ' : '') + imageContainerClasses + '">' +
										'<img src="' + aSlide.src + '" class="js-textbanner-image textbanner-image-effect ' + imageClasses + '">' +
									'</div>' +
									(aSlide.title || aSlide.description || aSlide.button ? '<div class="js-textbanner-text textbanner-text ' + (bannerModule ? 'col-md-6 px-3 px-md-5 text-center ' + evenClass : '') + textClasses + '">' : '') +
										(aSlide.title ? '<div class="h2 my-2 ' +  (bannerModule ? 'px-md-3 ' : '') + '">' + aSlide.title + '</div>' : '' ) +
										(aSlide.description ? '<div class="textbanner-paragraph font-small font-md-body ' +  (bannerModule ? 'pt-1 pb-md-0 px-md-3 ' : '') + '">' + aSlide.description + '</div>' : '' ) +
										(aSlide.button && aSlide.link ? '<div class="btn btn-primary btn-small mt-1 mt-md-2">' + aSlide.button + '</div>' : '' ) +
									(aSlide.title || aSlide.description || aSlide.button ? '</div>' : '') +
								(bannerModule ? '</div>' : '' ) +
							(aSlide.link ? '</a>' : '' ) +
						'</div>' +
					'</div>'
			}

			// Build swiper JS for Banners

			function initSwiperJS(bannerMainContainer, swiperId, swiperName, isModule){

				const bannerMargin = bannerMainContainer.attr('data-margin');
				const swiperDesktopColumns = isModule ? 1 : bannerMainContainer.attr('data-desktop-columns');

				createSwiper(`.js-swiper-${swiperId}`, {
					watchOverflow: true,
					threshold: 5,
					watchSlideProgress: true,
					watchSlidesVisibility: true,
					slideVisibleClass: 'js-swiper-slide-visible',
					spaceBetween: bannerMargin == 'false' ? 0 : 15,
					navigation: {
						nextEl: `.js-swiper-${swiperId}-next`,
						prevEl: `.js-swiper-${swiperId}-prev`
					},
					slidesPerView: 1.15,
					breakpoints: {
						768: {
							slidesPerView: swiperDesktopColumns,
						}
					}
				},
				function(swiperInstance) {
					window[swiperName] = swiperInstance;
				});
			}

			// Main banners: Banner content and order updates. General layout and format updates (for main and secondary banners)

			['banner', 'banner_promotional', 'banner_news', 'module'].forEach(setting => {

				const bannerName = setting.replace('_', '-');
				const bannerPluralName = 
					setting == 'banner' ? 'banners' : 
					setting == 'banner_promotional' ? 'banners-promotional' : 
					setting == 'banner_news' ? 'banners-news' : 
					setting == 'module' ? 'modules' :
					null;

				const isModule = setting == 'module';
				const $generalBannersContainer = $(`.js-home-${bannerName}`);

				// Main banner
				const $mainBannersContainer = $generalBannersContainer.find(`.js-${bannerPluralName}`);

				// Mobile banner
				const bannerMobileName = 
					setting == 'banner' ? 'banners-mobile' : 
					setting == 'banner_promotional' ? 'banners-promotional-mobile' : 
					setting == 'banner_news' ? 'banners-news-mobile' :
					null;
				const $mobileBannersContainer = $generalBannersContainer.find(`.js-${bannerMobileName}`);

				const bannerSwiper = 
					setting == 'banner' ? 'homeBannerSwiper' :
					setting == 'banner_promotional' ? 'homeBannerPromotionalSwiper' : 
					setting == 'banner_news' ? 'homeBannerNewsSwiper' :
					setting == 'module' ? 'homeModuleSwiper' :
					null;

				// Used for specific mobile images swiper updates
				const bannerSwiperMobile = 
					setting == 'banner' ? 'homeBannerMobileSwiper' : 
					setting == 'banner_promotional' ? 'homeBannerPromotionalMobileSwiper' : 
					setting == 'banner_news' ? 'homeBannerNewsMobileSwiper' :
					null;

				const bannerModuleSetting = setting == 'module' ? true : false;
				const $bannerMainItem = $generalBannersContainer.find('.js-banner');

				const desktopFormat = $generalBannersContainer.attr('data-desktop-format');
				const mobileFormat = $generalBannersContainer.attr('data-mobile-format');

				const desktopColumns = $generalBannersContainer.attr('data-desktop-columns');

				// Update section title
				handlers[`${setting}_title`] = new instaElements.Lambda(function(title){
					const $bannersMainTitle = $generalBannersContainer.find('.js-banners-section-title');
					if (title) {
						$bannersMainTitle.show();
						$bannersMainTitle.text(title);
					} else {
						$bannersMainTitle.hide();
					}
				});

				// Update banners content
				handlers[`${setting}`] = new instaElements.Lambda(function(slides){

					// Update text classes
					const textPosition = $generalBannersContainer.attr('data-text');
					const textClasses = textPosition == 'above' ? 'over-image' : '';
					const backgroundClasses = textPosition == 'outside' ? 'background-main' : '';

					// Update margin classes
					const bannerMargin = $generalBannersContainer.attr('data-margin');
					const marginClasses = bannerMargin == 'false' ? 'm-0' : '';

					// Update align classes
					const bannerAlign = $generalBannersContainer.attr('data-align');
					const alignClasses = bannerAlign == 'center' ? 'text-center' : '';

					// Update textbanner classes
					const textBannerClasses = marginClasses + ' ' + backgroundClasses + ' ' + alignClasses;

					// Update image classes
					const imageSize = $generalBannersContainer.attr('data-image');
					const imageClasses = imageSize == 'same' ? 'textbanner-image-background' : 'img-fluid d-block w-100';
					const imageContainerClasses = 
						imageSize == 'original' ? 'p-0' : 
						isModule && imageSize == 'same' ? 'textbanner-image-md' : '';

					// Update column classes
					const desktopColumnsClasses = $generalBannersContainer.attr('data-grid-classes');
					const columnClasses = desktopColumnsClasses;

					// Insta slider function
					function instaSlider() {
						// Update banner classes
						const bannerClasses = 'swiper-slide';

						if (!window[bannerSwiper]) {
							return;
						}

						// Try using already created swiper JS, if it fails initialize swipers again
						try{
							window[bannerSwiper].removeAllSlides();
							slides.forEach(function(aSlide){
								window[bannerSwiper].appendSlide(buildHomeBannerDom(aSlide, bannerClasses, textBannerClasses, columnClasses, textClasses, imageContainerClasses, imageClasses, bannerModuleSetting));
							});
							window[bannerSwiper].update();
						}catch(e){
							initSwiperJS($generalBannersContainer, bannerPluralName, bannerSwiper, isModule);

							setTimeout(function(){
								slides.forEach(function(aSlide){
									window[bannerSwiper].appendSlide(buildHomeBannerDom(aSlide, bannerClasses, textBannerClasses, columnClasses, textClasses, imageContainerClasses, imageClasses, bannerModuleSetting));
								});	
							},500);
						}
					}

					// Insta grid function
					function instaGrid() {
						// Update banner classes
						const bannerClasses = '';

						$mainBannersContainer.find('.js-banner').remove();
						slides.forEach(function(aSlide){
							$mainBannersContainer.find('.js-banner-row').append(buildHomeBannerDom(aSlide, bannerClasses, textBannerClasses, columnClasses, textClasses, imageContainerClasses, imageClasses, bannerModuleSetting));
						});
					}

					if (isModule) {
						const bannerFormat = $generalBannersContainer.attr('data-format');

						if (bannerFormat == 'slider') {
							instaSlider();
						} else {
							instaGrid();
						}

					} else {
						const desktopFormat = $generalBannersContainer.attr('data-desktop-format');
						const mobileFormat = $generalBannersContainer.attr('data-mobile-format');

						if (desktopFormat == 'slider' || mobileFormat == 'slider') {

							if (desktopFormat == 'slider' && mobileFormat == 'grid') {
								if (window.innerWidth > 768) {
									instaSlider();
								} else {
									instaGrid();
								}
							} else if (mobileFormat == 'slider' && desktopFormat == 'grid') {
								if (window.innerWidth < 768) {
									instaSlider();
								} else {
									instaGrid();
								}
							} else {
								instaSlider();
							}
						} else {
							instaGrid();
						}
					}
				});

				// Initialize swiper elements function
				function initSwiperElements(bannerRow, swiperId, swiperName, isModule) {
					const $bannerContainer = bannerRow.closest('.js-banner-container');
					const $bannerItem = $generalBannersContainer.find('.js-banner');

					if (isModule) {
						$bannerItem.removeClass('col-12');
					}

					// Update margin classes
					const bannerMargin = $generalBannersContainer.attr('data-margin');

					const swiperDesktopColumns = $generalBannersContainer.attr('data-desktop-columns');
					const swiperArrowClasses = bannerMargin == 'false' ? 'swiper-button-opacity' : 'swiper-button-outside';

					// Row to swiper wrapper
					bannerRow.addClass('swiper-wrapper');

					// Wrap everything inside a swiper container
					bannerRow.wrapAll(`<div class="js-swiper-${swiperId} swiper-container"></div>`);

					// Replace each banner into a slide
					$bannerItem.addClass('swiper-slide');

					// Add previous and next controls
					$bannerContainer.append(`
						<div class="js-swiper-${swiperId}-prev swiper-button-prev svg-icon-text d-none d-md-block ${swiperArrowClasses}">
							<svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
						</div>
						<div class="js-swiper-${swiperId}-next swiper-button-next svg-icon-text d-none d-md-block ${swiperArrowClasses}">
							<svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
						</div>
					`);

					// Initialize swiper
					initSwiperJS($generalBannersContainer, swiperId, swiperName, isModule);
				}

				// Reset swiper function
				function resetSwiperElements(bannersGroupContainer, bannerRow, swiperId, isModule) {

					const $bannerItem = $generalBannersContainer.find('.js-banner');
					const $bannerText = $generalBannersContainer.find('.js-textbanner');
					const $bannerTextEven = $generalBannersContainer.find('.js-banner-even');
					const desktopColumnsClasses = $generalBannersContainer.attr('data-grid-classes');

					if (isModule) {
						$bannerItem.addClass('col-12');
						$bannerText.addClass('mb-md-5 pb-md-3');
						$bannerTextEven.addClass('order-md-first');
					}

					// Remove duplicate slides and slider controls
					$mainBannersContainer.find('.swiper-slide-duplicate').remove();
					$mainBannersContainer.find(`.js-swiper-${swiperId}-prev`).remove();
					$mainBannersContainer.find(`.js-swiper-${swiperId}-next`).remove();

					// Swiper wrapper to row
					bannerRow.removeClass('swiper-wrapper').removeAttr('style');

					// Undo all slider wrappers and restore original classes
					bannerRow.unwrap();
					$bannerItem
						.removeClass('js-swiper-slide-visible swiper-slide-active swiper-slide-next swiper-slide-prev swiper-slide p-0')
						.addClass(desktopColumnsClasses)
						.removeAttr('style');
				}

				// Toggle grid and slider modules

				handlers[`module_slider`] = new instaElements.Lambda(function(moduleSlider){

					// Main banners markup container
					const $mainBannerRow = $mainBannersContainer.find('.js-banner-row');
					const $mainBanner = $mainBannersContainer.find('.js-textbanner');
					const $mainBannerText = $mainBannersContainer.find('.js-textbanner-text');

					if (moduleSlider) {
						$generalBannersContainer.attr('data-format', 'slider');
						$mainBanner.removeClass('mb-md-5 pb-md-3');
						$mainBannerText.removeClass('order-md-first');
						$mainBannerRow.removeClass('row');
					} else {
						$generalBannersContainer.attr('data-format', 'grid');
					}

					const bannerFormat = $generalBannersContainer.attr('data-format');

					const toSlider = bannerFormat == "slider";

					if ($generalBannersContainer.data('format') == bannerFormat) {
						// Nothing to do
						return;
					}

					// From grid to slider
					if (toSlider) {
						initSwiperElements($mainBannerRow, bannerPluralName, bannerSwiper, isModule);
					
					// From slider to grid
					} else {
						resetSwiperElements($generalBannersContainer, $mainBannerRow, bannerPluralName, isModule);

					}

					// Persist new format in data attribute
					$generalBannersContainer.data('format', bannerFormat);

				});

				// Update banner size
				handlers[`${setting}_same_size`] = new instaElements.Lambda(function(bannerSize){
					const $bannerImageContainer = $generalBannersContainer.find('.js-textbanner-image-container');
					const $bannerImage = $generalBannersContainer.find('.js-textbanner-image');

					if (bannerSize) {
						$generalBannersContainer.attr('data-image', 'same');
						$bannerImageContainer.removeClass('p-0');
						if (isModule) {
							$bannerImageContainer.addClass('textbanner-image-md');
						}
						$bannerImage.removeClass('img-fluid d-block w-100').addClass('textbanner-image-background');
					} else {
						$generalBannersContainer.attr('data-image', 'original');
						$bannerImageContainer.addClass('p-0');
						if (isModule) {
							$bannerImageContainer.removeClass('textbanner-image-md');
						}
						$bannerImage.removeClass('textbanner-image-background').addClass('img-fluid d-block w-100');
					}
				});

				if (!isModule) {
					// Remove grid classes on desktop and mobile slider
					if (desktopFormat == 'slider' && mobileFormat == 'slider') {
						$bannerMainItem.removeClass('col-md-3 col-md-4 col-md-6 col-md-12');
					}

					// Hide swiper arrows on desktop grid
					if (desktopFormat == 'grid') {
						$mainBannersContainer.find(`.js-swiper-${bannerPluralName}-prev`).removeClass('d-md-block');
						$mainBannersContainer.find(`.js-swiper-${bannerPluralName}-next`).removeClass('d-md-block');

						$mobileBannersContainer.find(`.js-swiper-${bannerMobileName}-prev`).removeClass('d-md-block');
						$mobileBannersContainer.find(`.js-swiper-${bannerMobileName}-next`).removeClass('d-md-block');
					}

					// Toggle grid and slider mobile view
					handlers[`${setting}_format_mobile`] = new instaElements.Lambda(function(bannerFormat){

						const toSlider = bannerFormat == "slider";

						const $bannerRow = $generalBannersContainer.find('.js-banner-row');
						const $mainBannerRow = $mainBannersContainer.find('.js-banner-row');
						const $bannerMobileRow = $mobileBannersContainer.find('.js-banner-row');
						
						const $bannerItem = $generalBannersContainer.find('.js-banner');

						const desktopFormat = $generalBannersContainer.attr('data-desktop-format');
						const mobileFormat = $generalBannersContainer.attr('data-mobile-format');

						const desktopColumns = $generalBannersContainer.attr('data-desktop-columns');

						if ($generalBannersContainer.attr('data-mobile-format') == bannerFormat) {
							// Nothing to do
							return;
						}

						// From grid to slider
						if (toSlider) {
							$generalBannersContainer.attr('data-mobile-format', 'slider');

							// Convert grid to slider if it's not yet
							if ($generalBannersContainer.find('.swiper-slide').length < 1) {
								initSwiperElements($mainBannerRow, bannerPluralName, bannerSwiper);
								initSwiperElements($bannerMobileRow, bannerMobileName, bannerSwiperMobile);
							}

							if (desktopFormat == 'grid') {
								$bannerRow.removeClass('px-2').addClass('swiper-mobile-only flex-nowrap flex-md-wrap row row-grid');
								if (window.innerWidth > 768) {
									$bannerRow.addClass('transform-none');
									$bannerItem.addClass('m-0 w-100');

									$mainBannersContainer.find(`.js-swiper-${bannerPluralName}-prev`).removeClass('d-md-block');
									$mainBannersContainer.find(`.js-swiper-${bannerPluralName}-next`).removeClass('d-md-block');

									$mobileBannersContainer.find(`.js-swiper-${bannerMobileName}-prev`).removeClass('d-md-block');
									$mobileBannersContainer.find(`.js-swiper-${bannerMobileName}-next`).removeClass('d-md-block');
								} else {
									$bannerRow.removeClass('transform-none');
									$bannerItem.removeClass('m-0 w-100');
								}
							} else {
								$bannerRow.removeClass('swiper-desktop-only flex-wrap flex-md-nowrap ml-md-0 swiper-mobile-only flex-md-wrap transform-none').addClass('swiper-products-slider flex-nowrap');
								if (window.innerWidth < 768) {
									$bannerItem.removeClass('m-0 w-100');
									initSwiperJS($mainBannersContainer, bannerPluralName, bannerSwiper);
									initSwiperJS($mobileBannersContainer, bannerMobileName, bannerSwiperMobile);
								}
							}

						// From slider to grid
						} else {
							$generalBannersContainer.attr('data-mobile-format', 'grid');

							if (desktopFormat == 'slider') {
								// Mantain desktop slider
								$bannerRow.removeClass('swiper-products-slider flex-nowrap').addClass('swiper-desktop-only flex-wrap flex-md-nowrap ml-md-0');
								if (window.innerWidth < 768) {
									$bannerRow.addClass('transform-none');
									$bannerItem.removeAttr('style');
									$mainBannersContainer.find(`.js-swiper-${bannerPluralName}-prev`).remove();
									$mainBannersContainer.find(`.js-swiper-${bannerPluralName}-next`).remove();

									$mobileBannersContainer.find(`.js-swiper-${bannerMobileName}-prev`).remove();
									$mobileBannersContainer.find(`.js-swiper-${bannerMobileName}-next`).remove();

									$bannerRow.find('.swiper-slide-duplicate').remove();
								} else {
									$bannerRow.removeClass('transform-none');
								}
							} else {

								// Reset swiper settings
								resetSwiperElements($mainBannersContainer, $mainBannerRow, bannerPluralName);
								resetSwiperElements($mobileBannersContainer, $bannerMobileRow, bannerMobileName);

								// Restore grid settings
								$bannerRow.removeClass('swiper-wrapper swiper-mobile-only flex-nowrap flex-md-wrap transform-none').removeAttr('style');
								if (desktopFormat == 'grid' && mobileFormat == 'grid') {
									$bannerRow.removeClass('swiper-wrapper swiper-desktop-only flex-wrap flex-md-nowrap ml-md-0 transform-none');
								}
							}

						}

						// Persist new format in data attribute
						$generalBannersContainer.attr('data-mobile-format', bannerFormat);
					});

					// Toggle grid and slider desktop view
					handlers[`${setting}_format_desktop`] = new instaElements.Lambda(function(bannerFormat){

						const toSlider = bannerFormat == "slider";

						const $bannerRow = $generalBannersContainer.find('.js-banner-row');
						const $mainBannerRow = $mainBannersContainer.find('.js-banner-row');
						const $bannerMobileRow = $mobileBannersContainer.find('.js-banner-row');

						const $bannerItem = $generalBannersContainer.find('.js-banner');

						const desktopFormat = $generalBannersContainer.attr('data-desktop-format');
						const mobileFormat = $generalBannersContainer.attr('data-mobile-format');

						const desktopColumns = $generalBannersContainer.attr('data-desktop-columns');

						if ($generalBannersContainer.attr('data-desktop-format') == bannerFormat) {
							// Nothing to do
							return;
						}

						// From grid to slider
						if (toSlider) {
							$generalBannersContainer.attr('data-desktop-format', 'slider');

							// Convert grid to slider if it's not yet
							if ($generalBannersContainer.find('.swiper-slide').length < 1) {
								initSwiperElements($mainBannerRow, bannerPluralName, bannerSwiper);
								initSwiperElements($bannerMobileRow, bannerMobileName, bannerSwiperMobile);
							}

							if (mobileFormat == 'grid') {
								$bannerRow.addClass('swiper-desktop-only flex-wrap flex-md-nowrap ml-md-0 row row-grid').removeClass("px-2");
								if (window.innerWidth < 768) {
									$bannerRow.addClass('transform-none');
									$bannerItem.addClass('m-0 w-100');
								} else {
									$bannerRow.removeClass('transform-none');
									$bannerItem.removeClass('m-0 w-100');
								}
							} else {
								$bannerRow.removeClass('swiper-mobile-only flex-md-wrap transform-none row-grid').addClass('swiper-products-slider px-2');

								$mainBannersContainer.find(`.js-swiper-${bannerPluralName}-prev`).addClass('d-md-block');
								$mainBannersContainer.find(`.js-swiper-${bannerPluralName}-next`).addClass('d-md-block');

								$mobileBannersContainer.find(`.js-swiper-${bannerMobileName}-prev`).addClass('d-md-block');
								$mobileBannersContainer.find(`.js-swiper-${bannerMobileName}-next`).addClass('d-md-block');
								if (window.innerWidth > 768) {
									$bannerItem.removeClass('m-0 w-100 w-auto');
									initSwiperJS($mainBannersContainer, bannerPluralName, bannerSwiper);
									initSwiperJS($mobileBannersContainer, bannerMobileName, bannerSwiperMobile);
								}
							}

						// From slider to grid
						} else {
							$generalBannersContainer.attr('data-desktop-format', 'grid');

							if (mobileFormat == 'slider') {
								// Mantain mobile slider
								$bannerRow.removeClass('swiper-products-slider').addClass('swiper-mobile-only flex-nowrap flex-md-wrap');
								if (window.innerWidth > 768) {
									$bannerRow.addClass('transform-none');
									$bannerItem.removeAttr('style');
									
									$mainBannersContainer.find(`.js-swiper-${bannerPluralName}-prev`).removeClass('d-md-block');
									$mainBannersContainer.find(`.js-swiper-${bannerPluralName}-next`).removeClass('d-md-block');

									$mobileBannersContainer.find(`.js-swiper-${bannerMobileName}-prev`).removeClass('d-md-block');
									$mobileBannersContainer.find(`.js-swiper-${bannerMobileName}-next`).removeClass('d-md-block');

									$bannerRow.find('.swiper-slide-duplicate').remove();
								} else {
									$bannerRow.removeClass('transform-none');
								}
							} else {

								// Reset swiper settings
								resetSwiperElements($mainBannersContainer, $mainBannerRow, bannerPluralName);
								resetSwiperElements($mobileBannersContainer, $bannerMobileRow, bannerMobileName);

								// Restore grid settings
								$bannerRow.removeClass('swiper-wrapper swiper-desktop-only flex-wrap flex-md-nowrap ml-md-0 transform-none').removeAttr('style');
								if (desktopFormat == 'grid' && mobileFormat == 'grid') {
									$bannerRow.removeClass('swiper-wrapper swiper-mobile-only flex-nowrap flex-md-wrap transform-none');
								}
							}

						}

						// Persist new format in data attribute
						$generalBannersContainer.attr('data-desktop-format', bannerFormat);
					});

					// Update banner text align
					handlers[`${setting}_align`] = new instaElements.Lambda(function(bannerAlign){
						const $bannerText = $generalBannersContainer.find('.js-textbanner');

						if (bannerAlign == 'center') {
							$generalBannersContainer.attr('data-align', 'center');
							$bannerText.addClass('text-center');
						} else {
							$generalBannersContainer.attr('data-align', 'left');
							$bannerText.removeClass('text-center');
						}
					});

					// Update banner text position
					handlers[`${setting}_text_outside`] = new instaElements.Lambda(function(hasOutsideText){
						const $bannerItem = $generalBannersContainer.find('.js-textbanner');
						const $bannerText = $generalBannersContainer.find('.js-textbanner-text');
						const $bannerLight = $bannerItem.hasClass('text-light');

						if (hasOutsideText) {
							$generalBannersContainer.attr('data-text', 'outside');
							$bannerText.removeClass('over-image').addClass('background-main');
							if ($bannerLight) {
								$bannerText.removeClass('text-light');
							}
						} else {
							$generalBannersContainer.attr('data-text', 'above');
							$bannerText.removeClass('background-main').addClass('over-image');
							if ($bannerLight) {
								$bannerText.addClass('text-light');
							}
						}
					});

					// Update banner margins
					handlers[`${setting}_without_margins`] = new instaElements.Lambda(function(bannerMargin){
						const desktopFormat = $generalBannersContainer.attr('data-desktop-format');
						const mobileFormat = $generalBannersContainer.attr('data-mobile-format');
						
						const $bannerSection = $generalBannersContainer.closest('.js-section-banner-home');
						const $bannerContainer = $generalBannersContainer.find('.js-banner-container');
						const $bannerRow = $generalBannersContainer.find('.js-banner-row:not(.js-banner-wrapper)');
						const $bannerWrapper = $generalBannersContainer.find('.js-banner-wrapper');
						const $bannerMainTitle = $(`.js-${bannerPluralName}-title`);
						const $bannerItemContainer = $generalBannersContainer.find('.js-banner');
						const $bannerItem = $bannerItemContainer.find('.js-textbanner');
						const $bannerItemSlide = $generalBannersContainer.find('.js-banner.swiper-slide');
						const $bannerArrows = $(`.js-swiper-${bannerPluralName}-prev, .js-swiper-${bannerPluralName}-next`);

						if (bannerMargin) {
							$generalBannersContainer.attr('data-margin', 'false');
							$bannerSection.addClass('section-home-color p-0');
							$bannerContainer.removeClass('container position-relative px-md-3').addClass('container-fluid p-0 overflow-none');
							$bannerRow.removeClass('px-2').addClass('no-gutters');
							$bannerWrapper.removeClass('row-grid').addClass('no-gutters');
							$bannerMainTitle.addClass('container');
							$bannerItemContainer.addClass('m-0');
							$bannerItem.addClass('m-0');
							$bannerItemSlide.addClass('p-0');
							$bannerArrows.removeClass('swiper-button-outside').addClass('swiper-button-opacity');
						} else {
							$generalBannersContainer.attr('data-margin', 'true');
							$bannerSection.removeClass('section-home-color p-0');
							$bannerContainer.removeClass('container-fluid p-0 overflow-none').addClass('container position-relative p-0 px-md-3');
							$bannerRow.removeClass('no-gutters').addClass('px-2');
							$bannerWrapper.removeClass('no-gutters').addClass('row-grid');
							$bannerMainTitle.removeClass('container');
							$bannerItemContainer.removeClass('m-0');
							$bannerItem.removeClass('m-0');
							$bannerItemSlide.removeClass('p-0');
							$bannerArrows.removeClass('swiper-button-opacity').addClass('swiper-button-outside');
						}
						// Updates slider width to avoids swipes inconsistency
						if ((desktopFormat == 'slider' && window.innerWidth > 768) || (mobileFormat == 'slider' && window.innerWidth < 768)) {
							// Try using already created swiper JS, if it fails initialize swipers again
							try{
								if (bannerMargin) {
									window[bannerSwiper].params.spaceBetween = 0;
									window[bannerSwiperMobile].params.spaceBetween = 0;
								} else {
									window[bannerSwiper].params.spaceBetween = 15;
									window[bannerSwiperMobile].params.spaceBetween = 15;
								}

								window[bannerSwiper].params.observer = true;
								window[bannerSwiper].update();

								window[bannerSwiperMobile].params.observer = true;
								window[bannerSwiperMobile].update();
							}catch(e){
								initSwiperJS($generalBannersContainer, bannerPluralName, bannerSwiper);
								initSwiperJS($generalBannersContainer, bannerMobileName, bannerSwiperMobile);
							}
						}
					});

					// Update quantity desktop banners
					handlers[`${setting}_columns_desktop`] = new instaElements.Lambda(function(bannerQuantity){
						const $bannerItem = $generalBannersContainer.find('.js-banner');
						const desktopFormat = $generalBannersContainer.attr('data-desktop-format');

						$bannerItem.removeClass('col-md-3 col-md-4 col-md-6 col-md-12');
						if (bannerQuantity == 4) {
							$generalBannersContainer.attr('data-desktop-columns', bannerQuantity);
							$generalBannersContainer.attr('data-grid-classes', 'col-md-3');

							$bannerItem.addClass('col-md-3');

							if (desktopFormat == 'slider') {
								if (window.innerWidth > 768) {
									window[bannerSwiper].params.slidesPerView = 4;
									window[bannerSwiperMobile].params.slidesPerView = 4;
								}
							}
						} else if (bannerQuantity == 3) {
							$generalBannersContainer.attr('data-desktop-columns', bannerQuantity);
							$generalBannersContainer.attr('data-grid-classes', 'col-md-4');

							$bannerItem.addClass('col-md-4');

							if (desktopFormat == 'slider') {
								if (window.innerWidth > 768) {
									window[bannerSwiper].params.slidesPerView = 3;
									window[bannerSwiperMobile].params.slidesPerView = 3;
								}
							}
						} else if (bannerQuantity == 2) {
							$generalBannersContainer.attr('data-desktop-columns', bannerQuantity);
							$generalBannersContainer.attr('data-grid-classes', 'col-md-6');

							$bannerItem.addClass('col-md-6');

							if (desktopFormat == 'slider') {
								if (window.innerWidth > 768) {
									window[bannerSwiper].params.slidesPerView = 2;
									window[bannerSwiperMobile].params.slidesPerView = 2;
								}
							}
						} else if (bannerQuantity == 1) {
							$generalBannersContainer.attr('data-desktop-columns', bannerQuantity);
							$generalBannersContainer.attr('data-grid-classes', 'col-md-12');

							$bannerItem.addClass('col-md-12');

							if (desktopFormat == 'slider') {
								if (window.innerWidth > 768) {
									window[bannerSwiper].params.slidesPerView = 1;
									window[bannerSwiperMobile].params.slidesPerView = 1;
								}
							}
						}

						if ((desktopFormat == 'slider' && window.innerWidth > 768) || (mobileFormat == 'slider' && window.innerWidth < 768)) {
							// Try using already created swiper JS, if it fails initialize swipers again
							try{
								window[bannerSwiper].update();
								window[bannerSwiperMobile].update();
							}catch(e){
								initSwiperJS($generalBannersContainer, bannerPluralName, bannerSwiper);
								initSwiperJS($generalBannersContainer, bannerMobileName, bannerSwiperMobile);
							}
						}
					});
					
					// Toggle mobile banners visibility

					handlers[`toggle_${setting}_mobile`] = new instaElements.Lambda(function(showMobileBanner){
						const desktopFormat = $generalBannersContainer.attr('data-desktop-format');
						const mobileFormat = $generalBannersContainer.attr('data-mobile-format');

						$mainBannersContainer.removeClass("hidden d-md-none d-none d-md-block");
						$mobileBannersContainer.removeClass("hidden d-md-none d-none d-md-block");

						if (showMobileBanner) {
							// Each breakpoint shows on it's own device content
							$mainBannersContainer.addClass("d-none d-md-block");
							$mobileBannersContainer.addClass("d-md-none");
							$generalBannersContainer.attr('data-mobile-banners', '1');

							if (desktopFormat == 'slider' || mobileFormat == 'slider') {

								if (desktopFormat == 'slider' && mobileFormat == 'grid') {
									if (window.innerWidth > 768) {
										// Try using already created swiper JS, if it fails initialize swipers again
										try{
											window[bannerSwiperMobile].update();
										}catch(e){
											initSwiperJS($generalBannersContainer, bannerMobileName, bannerSwiperMobile);
										}
									}
								} else if (mobileFormat == 'slider' && desktopFormat == 'grid') {
									if (window.innerWidth < 768) {
										// Try using already created swiper JS, if it fails initialize swipers again
										try{
											window[bannerSwiperMobile].update();
										}catch(e){
											initSwiperJS($generalBannersContainer, bannerMobileName, bannerSwiperMobile);
										}
									}
								} else {
									// Try using already created swiper JS, if it fails initialize swipers again
									try{
										window[bannerSwiperMobile].update();
									}catch(e){
										initSwiperJS($generalBannersContainer, bannerMobileName, bannerSwiperMobile);
									}
								}
							}
						} else {
							// Hide mobile banners
							$mobileBannersContainer.addClass("d-none");
							$generalBannersContainer.attr('data-mobile-banners', '0');
							if (desktopFormat == 'slider' || mobileFormat == 'slider') {

								if (desktopFormat == 'slider' && mobileFormat == 'grid') {
									if (window.innerWidth > 768) {
										// Try using already created swiper JS, if it fails initialize swipers again
										try{
											window[bannerSwiperMobile].update();
										}catch(e){
											initSwiperJS($generalBannersContainer, bannerMobileName, bannerSwiperMobile);
										}
									}
								} else if (mobileFormat == 'slider' && desktopFormat == 'grid') {
									if (window.innerWidth < 768) {
										// Try using already created swiper JS, if it fails initialize swipers again
										try{
											window[bannerSwiperMobile].update();
										}catch(e){
											initSwiperJS($generalBannersContainer, bannerMobileName, bannerSwiperMobile);
										}
									}
								} else {
									// Try using already created swiper JS, if it fails initialize swipers again
									try{
										window[bannerSwiperMobile].update();
									}catch(e){
										initSwiperJS($generalBannersContainer, bannerMobileName, bannerSwiperMobile);
									}
								}
							}
						}
					});

				}

			});

			// Mobile banners: Banner content and order updates

			['banner_mobile', 'banner_promotional_mobile', 'banner_news_mobile'].forEach(setting => {

				const bannerName = setting.replace('_', '-').replace(/[-_]mobile$/, '');
				const bannerMobileName = 
					setting == 'banner_mobile' ? 'banners-mobile' : 
					setting == 'banner_promotional_mobile' ? 'banners-promotional-mobile' : 
					setting == 'banner_news_mobile' ? 'banners-news-mobile' :
					null;
				const $generalBannersContainer = $(`.js-home-${bannerName}`);

				// Target specific breakpoint to build correct slides on each device
				const $mobileBannersContainer = $generalBannersContainer.find(`.js-${bannerMobileName}`);

				const bannerSwiperMobile = 
					setting == 'banner_mobile' ? 'homeBannerMobileSwiper' : 
					setting == 'banner_promotional_mobile' ? 'homeBannerPromotionalMobileSwiper' : 
					setting == 'banner_news_mobile' ? 'homeBannerNewsMobileSwiper' :
					null;

				const desktopFormat = $generalBannersContainer.attr('data-desktop-format');
				const mobileFormat = $generalBannersContainer.attr('data-mobile-format');

				const desktopColumns = $generalBannersContainer.attr('data-desktop-columns');

				const bannerModuleSetting = false;
				const isModule = false;

				// Update banners content
				handlers[`${setting}`] = new instaElements.Lambda(function(slides){

					// Update text classes
					const textPosition = $generalBannersContainer.attr('data-text');
					const textClasses = textPosition == 'above' ? 'over-image' : '';
					const backgroundClasses = textPosition == 'outside' ? 'background-main' : '';

					// Update margin classes
					const bannerMargin = $generalBannersContainer.attr('data-margin');
					const marginClasses = bannerMargin == 'false' ? 'm-0' : '';

					// Update align classes
					const bannerAlign = $generalBannersContainer.attr('data-align');
					const alignClasses = bannerAlign == 'center' ? 'text-center' : '';

					// Update textbanner classes
					const textBannerClasses = marginClasses + ' ' + backgroundClasses + ' ' + alignClasses;

					// Update image classes
					const imageSize = $generalBannersContainer.attr('data-image');
					const imageClasses = imageSize == 'same' ? 'textbanner-image-background' : 'img-fluid d-block w-100';
					const imageContainerClasses = imageSize == 'original' ? 'p-0' : '';

					// Update column classes
					const desktopColumnsClasses = $generalBannersContainer.attr('data-grid-classes');
					const columnClasses = desktopColumnsClasses;

					// Insta slider function
					function instaSlider() {
						// Update banner classes
						const bannerClasses = 'swiper-slide';

						if (!window[bannerSwiperMobile]) {
							return;
						}

						// Try using already created swiper JS, if it fails initialize swipers again
						try{
							window[bannerSwiperMobile].removeAllSlides();
							slides.forEach(function(aSlide){
								window[bannerSwiperMobile].appendSlide(buildHomeBannerDom(aSlide, bannerClasses, textBannerClasses, columnClasses, textClasses, imageContainerClasses, imageClasses, bannerModuleSetting));
							});
							window[bannerSwiperMobile].update();
						}catch(e){
							initSwiperJS($generalBannersContainer, bannerMobileName, bannerSwiperMobile, isModule);

							setTimeout(function(){
								slides.forEach(function(aSlide){
									window[bannerSwiperMobile].appendSlide(buildHomeBannerDom(aSlide, bannerClasses, textBannerClasses, columnClasses, textClasses, imageContainerClasses, imageClasses, bannerModuleSetting));
								});	
							},500);
						}
					}

					// Insta grid function
					function instaGrid() {
						// Update banner classes
						const bannerClasses = '';

						$mobileBannersContainer.find('.js-banner').remove();
						slides.forEach(function(aSlide){
							$mobileBannersContainer.find('.js-banner-row').append(buildHomeBannerDom(aSlide, bannerClasses, textBannerClasses, columnClasses, textClasses, imageContainerClasses, imageClasses));
						});
					}

					const desktopFormat = $generalBannersContainer.attr('data-desktop-format');
					const mobileFormat = $generalBannersContainer.attr('data-mobile-format');

					if (desktopFormat == 'slider' || mobileFormat == 'slider') {

						if (desktopFormat == 'slider' && mobileFormat == 'grid') {
							if (window.innerWidth > 768) {
								instaSlider();
							} else {
								instaGrid();
							}
						} else if (mobileFormat == 'slider' && desktopFormat == 'grid') {
							if (window.innerWidth < 768) {
								instaSlider();
							} else {
								instaGrid();
							}
						} else {
							instaSlider();
						}
					} else {
						instaGrid();
					}
				});
			});

			// ----------------------------------- Newsletter -----------------------------------

			// Updates title and text for newsletter form
			['title', 'text'].forEach(setting => {
				handlers[`home_news_${setting}`] = new instaElements.Text({
					element: `.js-home-newsletter-${setting}`,
					show: function(){
						$(this).show();
					},
					hide: function(){
						$(this).hide();
					},
				});
			});

			// Content align
			handlers.home_news_align = new instaElements.Lambda(function(alignText){

				const $container = $('.js-home-newsletter-form');
				const $newsletter = $(".js-home-newsletter");

				if (alignText == 'center') {
					$container.addClass("justify-content-center text-center").removeClass("mx-md-5 pl-md-3");
					$newsletter.addClass("text-center m-auto");
				} else {
					$container.addClass("justify-content-start mx-md-5 pl-md-3").removeClass("justify-content-center text-center");
					$newsletter.removeClass("text-center m-auto");
				}
			});

			// Update newsletter full
			handlers.newsletter_full = new instaElements.Lambda(function(newsletterFull){
				const $container = $('.js-home-newsletter-section');
				const $internalContainer = $(".js-home-newsletter-internal-container");

				if (newsletterFull) {
					$container.removeClass("container").addClass("container-fluid p-0");
					$internalContainer.removeClass("mx-4 mx-md-5").addClass("container px-4 px-md-3");
				}else{
					$container.removeClass("container-fluid p-0").addClass("container");
					$internalContainer.removeClass("container px-4 px-md-3").addClass("mx-4 mx-md-5");
					
				}
			});

			// Newsletter images visibility
			function newsletterImagesVisibility(){

				const $newsContainer = $(".js-home-newsletter-container"); 
				const $newsImagesContainer = $(".js-home-newsletter-image-container"); 
				const $newsImage = $newsImagesContainer.find('.js-home-newsletter-image');
				const $newsImageMobile = $newsImagesContainer.find('.js-home-newsletter-image-mobile');
				const hasImage = $newsImagesContainer.find('.js-home-newsletter-image').attr('src');
				const hasImageMobile = $newsImagesContainer.find('.js-home-newsletter-image-mobile').attr('src');

				const hasImages = $newsImage.attr('src') || $newsImageMobile.attr('src');

				if(hasImages){
					$newsImagesContainer.show();
					$newsContainer.addClass("section-newsletter-home-images");
				}else{
					$newsImagesContainer.hide();
					$newsContainer.removeClass("section-newsletter-home-images");
				}

				// Hides mobile image if has desktop image

				$newsImage.removeClass("d-block d-none d-md-block d-md-none");
				$newsImageMobile.removeClass("d-block d-none d-md-block d-md-none");

				if (hasImage) {
					$newsImageMobile.addClass('d-block d-md-none');
				} else {
					$newsImageMobile.removeClass('d-block d-md-none');
				}
				// Hides desktop image if has mobile image
				if (hasImageMobile) {
					$newsImage.addClass('d-none d-md-block');
				} else {
					$newsImage.removeClass('d-none d-md-block');
				}
			}

			newsletterImagesVisibility();

			// Updates newsletter images
			['image', 'image_mobile'].forEach(setting => {
				const imageName = setting.replace('_', '-');
				handlers[`home_news_${setting}.jpg`] = new instaElements.Image({
					element: `.js-home-newsletter-${imageName}`,
					show: function() {
						$(this).show();
						newsletterImagesVisibility();
					},
					hide: function() {
						$(this).hide();
						newsletterImagesVisibility();
					},
				});
			});

			// Newsletter colors
			handlers.home_news_colors = new instaElements.Lambda(function(newsColors){

				const $container = $('.js-home-newsletter-container');

				if (newsColors) {
					$container.addClass("section-newsletter-home-colors");
				} else {
					$container.removeClass("section-newsletter-home-colors");
				}
			});

			return handlers;
		}
	};
})(jQueryNuvem);