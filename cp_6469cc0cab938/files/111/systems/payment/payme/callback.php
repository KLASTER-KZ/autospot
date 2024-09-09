<?php 

define('unisitecms', true);
session_start();

$config = require "../../../config.php";
include_once( $config["basePath"] . "/systems/classes/UniSite.php");

$Profile = new Profile();

$param = paymentParams('payme');

if (!function_exists('getallheaders')) {
    function getallheaders()
    {
        $headers = '';
        foreach ($_SERVER as $name => $value) {
            if (substr($name, 0, 5) == 'HTTP_') {
                $headers[str_replace(' ', '-', ucwords(strtolower(str_replace('_', ' ', substr($name, 5)))))] = $value;
            }
        }
        return $headers;
    }
}

require_once 'vendor/autoload.php';

use Paycom\Application;

$paycomConfig = [
    'merchant_id' => $param['merchant_id'],
    'login' => 'Paycom',
    'key' => $param['secret_key'],
];

$application = new Application($paycomConfig);
$application->run();

?>