<div class="form-group row d-flex align-items-center mb-5">
  <label class="col-lg-3 form-control-label">Обработчик оплаты</label>
  <div class="col-lg-5">
    <span><?php echo $config["urlPath"]; ?>/systems/payment/<?php echo $sql["code"]; ?>/callback.php</span>
  </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
  <label class="col-lg-3 form-control-label">API Login </label>
  <div class="col-lg-5">
    <input type="text" class="form-control" value="<?php echo $param["id_merchant"]; ?>" name="payment_param[id_merchant]">
  </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
  <label class="col-lg-3 form-control-label">API Secret</label>
  <div class="col-lg-5">
    <input type="text" class="form-control" value="<?php echo $param["key"]; ?>" name="payment_param[key]">
  </div>
</div>


<div class="form-group row d-flex align-items-center mb-5">
  <label class="col-lg-3 form-control-label">Перенаправлять клиента при отмене оплаты</label>
  <div class="col-lg-5">
    <input type="text" class="form-control" value="<?php echo $param["link_cancel"] ? $param["link_cancel"] : $config["urlPath"] . "/pay/status/fail"; ?>" name="payment_param[link_cancel]">
  </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
  <label class="col-lg-3 form-control-label">Перенаправлять клиента при успешной оплате</label>
  <div class="col-lg-5">
    <input type="text" class="form-control" value="<?php echo $param["link_successful"] ? $param["link_successful"] : $config["urlPath"] . "/pay/status/fail"; ?>" name="payment_param[link_successful]">
  </div>
</div>

