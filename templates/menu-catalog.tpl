    <div class="header-wow-top css-dasfwe d-none d-lg-block">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-12 text-left" style="padding: 3px; margin-left: 4px;">
                    <?php
						if (count($getCategoryBoard["category_board_id_parent"][0])) {
							foreach ($getCategoryBoard["category_board_id_parent"][0] as $value) {
							?>
                            <a href="<?php echo $CategoryBoard->alias($value["category_board_chain"]); ?>" class="css-dfdre54 col-6">
                                <?php if ($value["category_board_image"]) { ?>
                                    <?php echo $ULang->t($value["category_board_name"], ["table" => "uni_category_board", "field" => "category_board_name"]); ?>
								<?php } ?>
							</a>
                            <?php
							}
						}
					?>
					
					<a href="/promo/razvivayte-biznes-na-autospot/" class="css-dfdre54"><span class="css-ew23gww">
					<?php echo $ULang->t("Для бизнеса") ?></span>
					</a>
					
				</div>
			</div>
		</div>
	</div>



