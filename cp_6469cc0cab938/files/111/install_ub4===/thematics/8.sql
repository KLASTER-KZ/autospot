-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Июл 18 2022 г., 22:37
-- Версия сервера: 5.7.38-0ubuntu0.18.04.1
-- Версия PHP: 7.3.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `testing`
--

-- --------------------------------------------------------

--
-- Структура таблицы `uni_ads_filters`
--

CREATE TABLE `uni_ads_filters` (
  `ads_filters_id` int(11) NOT NULL,
  `ads_filters_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ads_filters_visible` int(1) NOT NULL DEFAULT '1',
  `ads_filters_type` varchar(50) CHARACTER SET utf8 NOT NULL,
  `ads_filters_position` int(11) NOT NULL DEFAULT '0',
  `ads_filters_podcat` int(1) NOT NULL DEFAULT '1',
  `ads_filters_id_parent` int(11) NOT NULL DEFAULT '0',
  `ads_filters_alias` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ads_filters_required` int(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `uni_ads_filters`
--

INSERT INTO `uni_ads_filters` (`ads_filters_id`, `ads_filters_name`, `ads_filters_visible`, `ads_filters_type`, `ads_filters_position`, `ads_filters_podcat`, `ads_filters_id_parent`, `ads_filters_alias`, `ads_filters_required`) VALUES
(134, 'Тип', 1, 'select', 126, 1, 0, 'tip', 1),
(135, 'Тип измерений', 1, 'select', 127, 1, 0, 'tip-izmereniy', 1),
(136, 'Тип', 1, 'select', 128, 1, 0, 'tip', 1),
(137, 'Тип', 1, 'select', 129, 1, 0, 'tip', 1),
(138, 'Тип', 1, 'select', 130, 1, 0, 'tip', 1),
(139, 'Тип', 1, 'select', 131, 1, 0, 'tip', 1),
(140, 'Тип', 1, 'select', 132, 1, 0, 'tip', 1),
(141, 'Тип', 1, 'select', 133, 1, 0, 'tip', 1),
(142, 'Тип', 1, 'select', 134, 1, 0, 'tip', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `uni_ads_filters_alias`
--

CREATE TABLE `uni_ads_filters_alias` (
  `ads_filters_alias_id` int(11) NOT NULL,
  `ads_filters_alias_id_filter_item` int(11) NOT NULL DEFAULT '0',
  `ads_filters_alias_title` varchar(255) DEFAULT NULL,
  `ads_filters_alias_alias` varchar(255) DEFAULT NULL,
  `ads_filters_alias_id_cat` int(11) NOT NULL DEFAULT '0',
  `ads_filters_alias_desc` text,
  `ads_filters_alias_h1` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `uni_ads_filters_category`
--

CREATE TABLE `uni_ads_filters_category` (
  `ads_filters_category_id` int(11) NOT NULL,
  `ads_filters_category_id_cat` int(11) NOT NULL DEFAULT '0',
  `ads_filters_category_id_filter` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `uni_ads_filters_category`
--

INSERT INTO `uni_ads_filters_category` (`ads_filters_category_id`, `ads_filters_category_id_cat`, `ads_filters_category_id_filter`) VALUES
(797, 277, 134),
(798, 278, 135),
(799, 280, 136),
(800, 281, 137),
(801, 282, 138),
(802, 283, 139),
(803, 284, 140),
(804, 285, 141),
(805, 286, 142);

-- --------------------------------------------------------

--
-- Структура таблицы `uni_ads_filters_items`
--

CREATE TABLE `uni_ads_filters_items` (
  `ads_filters_items_id` int(11) NOT NULL,
  `ads_filters_items_id_filter` int(11) NOT NULL DEFAULT '0',
  `ads_filters_items_value` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ads_filters_items_id_item_parent` int(11) NOT NULL DEFAULT '0',
  `ads_filters_items_alias` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ads_filters_items_sort` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `uni_ads_filters_items`
--

INSERT INTO `uni_ads_filters_items` (`ads_filters_items_id`, `ads_filters_items_id_filter`, `ads_filters_items_value`, `ads_filters_items_id_item_parent`, `ads_filters_items_alias`, `ads_filters_items_sort`) VALUES
(1325, 134, 'Входные', 0, 'vhodnye', 0),
(1326, 134, 'Дверные коробки', 0, 'dvernye-korobki', 0),
(1327, 134, 'Дверные ручки', 0, 'dvernye-ruchki', 0),
(1328, 134, 'Межкомнатные', 0, 'mezhkomnatnye', 0),
(1329, 135, 'Давление', 0, 'davlenie', 0),
(1330, 135, 'Длина', 0, 'dlina', 0),
(1331, 135, 'Параметры тока', 0, 'parametry-toka', 0),
(1332, 135, 'Температура', 0, 'temperatura', 0),
(1333, 135, 'Углы', 0, 'ugly', 0),
(1334, 136, 'Вентиляция', 0, 'ventilyaciya', 0),
(1335, 136, 'Газовые баллоны', 0, 'gazovye-ballony', 0),
(1336, 136, 'Камины и печи', 0, 'kaminy-i-pechi', 0),
(1337, 136, 'Отопительные котлы', 0, 'otopitelnye-kotly', 0),
(1338, 136, 'Радиаторы', 0, 'radiatory', 0),
(1339, 136, 'Теплый пол', 0, 'teplyy-pol', 0),
(1340, 137, 'Комплектующие', 0, 'komplektuyushchie', 0),
(1341, 137, 'Натяжные', 0, 'natyazhnye', 0),
(1342, 137, 'Плиточные', 0, 'plitochnye', 0),
(1343, 137, 'Реечные', 0, 'reechnye', 0),
(1344, 138, 'Валики и кисти', 0, 'valiki-i-kisti', 0),
(1345, 138, 'Клещи и бокорезы', 0, 'kleshchi-i-bokorezy', 0),
(1346, 138, 'Ключи', 0, 'klyuchi', 0),
(1347, 138, 'Молотки и кувалды', 0, 'molotki-i-kuvaldy', 0),
(1348, 138, 'Напильники', 0, 'napilniki', 0),
(1349, 138, 'Отвертки', 0, 'otvertki', 0),
(1350, 138, 'Пассатижи и плоскогубцы', 0, 'passatizhi-i-ploskogubcy', 0),
(1351, 138, 'Паяльники', 0, 'payalniki', 0),
(1352, 138, 'Пилы', 0, 'pily', 0),
(1353, 138, 'Тиски', 0, 'tiski', 0),
(1354, 138, 'Тиски и струбцины', 0, 'tiski-i-strubciny', 0),
(1355, 139, 'Ванны', 0, 'vanny', 0),
(1356, 139, 'Водонагреватели', 0, 'vodonagrevateli', 0),
(1357, 139, 'Душевые кабины', 0, 'dushevye-kabiny', 0),
(1358, 139, 'Души', 0, 'dushi', 0),
(1359, 139, 'Насосы', 0, 'nasosy', 0),
(1360, 139, 'Полотенцесушители', 0, 'polotencesushiteli', 0),
(1361, 139, 'Раковины, умывальники', 0, 'rakoviny-umyvalniki', 0),
(1362, 139, 'Смесители', 0, 'smesiteli', 0),
(1363, 139, 'Сушилки для рук', 0, 'sushilki-dlya-ruk', 0),
(1364, 139, 'Счетчики воды', 0, 'schetchiki-vody', 0),
(1365, 139, 'Трубы и фитинги', 0, 'truby-i-fitingi', 0),
(1366, 139, 'Унитазы и биде', 0, 'unitazy-i-bide', 0),
(1367, 140, 'Гипсокартон', 0, 'gipsokarton', 0),
(1368, 140, 'Кирпичи и блоки', 0, 'kirpichi-i-bloki', 0),
(1369, 140, 'Лакокрасочные материалы', 0, 'lakokrasochnye-materialy', 0),
(1370, 140, 'Напольные покрытия', 0, 'napolnye-pokrytiya', 0),
(1371, 140, 'Обои', 0, 'oboi', 0),
(1372, 140, 'Пиломатериалы', 0, 'pilomaterialy', 0),
(1373, 140, 'Плитка', 0, 'plitka', 0),
(1374, 140, 'Сайдинг и панели', 0, 'sayding-i-paneli', 0),
(1375, 140, 'Сухие смеси', 0, 'suhie-smesi', 0),
(1376, 141, 'Аккумуляторные батареи', 0, 'akkumulyatornye-batarei', 0),
(1377, 141, 'Выключатели и переключатели', 0, 'vyklyuchateli-i-pereklyuchateli', 0),
(1378, 141, 'Источники бесперебойного питания', 0, 'istochniki-bespereboynogo-pitaniya', 0),
(1379, 141, 'Предохранители', 0, 'predohraniteli', 0),
(1380, 141, 'Провода и кабели', 0, 'provoda-i-kabeli', 0),
(1381, 141, 'Розетки', 0, 'rozetki', 0),
(1382, 141, 'Стабилизаторы напряжения', 0, 'stabilizatory-napryazheniya', 0),
(1383, 141, 'Трансформаторы', 0, 'transformatory', 0),
(1384, 141, 'Удлинители и переходники', 0, 'udliniteli-i-perehodniki', 0),
(1385, 141, 'Щиты и шкафы', 0, 'shchity-i-shkafy', 0),
(1386, 141, 'Электрогенераторы', 0, 'elektrogeneratory', 0),
(1387, 141, 'Электросчетчики', 0, 'elektroschetchiki', 0),
(1388, 142, 'Аккумуляторные отвертки', 0, 'akkumulyatornye-otvertki', 0),
(1389, 142, 'Бензогенераторы', 0, 'benzogeneratory', 0),
(1390, 142, 'Бетономешалки', 0, 'betonomeshalki', 0),
(1391, 142, 'Бороздоделы', 0, 'borozdodely', 0),
(1392, 142, 'Виброплиты', 0, 'vibroplity', 0),
(1393, 142, 'Гайковерты', 0, 'gaykoverty', 0),
(1394, 142, 'Глубинные вибраторы', 0, 'glubinnye-vibratory', 0),
(1395, 142, 'Граверы', 0, 'gravery', 0),
(1396, 142, 'Дрели и шуруповерты', 0, 'dreli-i-shurupoverty', 0),
(1397, 142, 'Клеевые пистолеты', 0, 'kleevye-pistolety', 0),
(1398, 142, 'Краскопульты и аэрографы', 0, 'kraskopulty-i-aerografy', 0),
(1399, 142, 'Лобзики', 0, 'lobziki', 0),
(1400, 142, 'Наборы электроинструментов', 0, 'nabory-elektroinstrumentov', 0),
(1401, 142, 'Отбойники', 0, 'otboyniki', 0),
(1402, 142, 'Перфораторы', 0, 'perforatory', 0),
(1403, 142, 'Плазморезы', 0, 'plazmorezy', 0),
(1404, 142, 'Реноваторы', 0, 'renovatory', 0),
(1405, 142, 'Рубанки', 0, 'rubanki', 0),
(1406, 142, 'Сварочные аппараты', 0, 'svarochnye-apparaty', 0),
(1407, 142, 'Степлеры', 0, 'steplery', 0),
(1408, 142, 'Строительные миксеры', 0, 'stroitelnye-miksery', 0),
(1409, 142, 'Строительные пылесосы', 0, 'stroitelnye-pylesosy', 0),
(1410, 142, 'Строительные фены', 0, 'stroitelnye-feny', 0),
(1411, 142, 'Тельферы', 0, 'telfery', 0),
(1412, 142, 'УШМ (болгарки)', 0, 'ushm-bolgarki', 0),
(1413, 142, 'Фрезеры', 0, 'frezery', 0),
(1414, 142, 'Шлифовальные машины', 0, 'shlifovalnye-mashiny', 0),
(1415, 142, 'Штроборезы', 0, 'shtroborezy', 0),
(1416, 142, 'Электрические ножницы', 0, 'elektricheskie-nozhnicy', 0),
(1417, 142, 'Электро- и бензопилы', 0, 'elektro-i-benzopily', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `uni_category_board`
--

CREATE TABLE `uni_category_board` (
  `category_board_id` int(11) NOT NULL,
  `category_board_name` varchar(150) CHARACTER SET utf8 NOT NULL,
  `category_board_visible` int(11) NOT NULL DEFAULT '1',
  `category_board_title` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `category_board_id_position` int(11) NOT NULL DEFAULT '0',
  `category_board_text` text CHARACTER SET utf8,
  `category_board_id_parent` int(11) NOT NULL DEFAULT '0',
  `category_board_image` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `category_board_description` text CHARACTER SET utf8,
  `category_board_alias` varchar(255) CHARACTER SET utf8 NOT NULL,
  `category_board_count_view` int(11) NOT NULL DEFAULT '0',
  `category_board_date_view` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `category_board_price` float NOT NULL DEFAULT '0',
  `category_board_count_free` int(11) NOT NULL DEFAULT '0',
  `category_board_status_paid` int(11) NOT NULL DEFAULT '0',
  `category_board_display_price` int(1) NOT NULL DEFAULT '1',
  `category_board_auction` int(11) NOT NULL DEFAULT '0',
  `category_board_secure` int(11) NOT NULL DEFAULT '0',
  `category_board_h1` varchar(255) DEFAULT NULL,
  `category_board_auto_title` int(1) NOT NULL DEFAULT '0',
  `category_board_online_view` int(1) NOT NULL DEFAULT '0',
  `category_board_auto_title_template` varchar(255) DEFAULT NULL,
  `category_board_show_index` int(1) NOT NULL DEFAULT '0',
  `category_board_marketplace` int(1) NOT NULL DEFAULT '0',
  `category_board_booking` int(1) NOT NULL DEFAULT '0',
  `category_board_booking_variant` int(1) NOT NULL DEFAULT '0',
  `category_board_variant_price_id` int(11) NOT NULL DEFAULT '0',
  `category_board_measures_price` text,
  `category_board_rules` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `uni_category_board`
--

INSERT INTO `uni_category_board` (`category_board_id`, `category_board_name`, `category_board_visible`, `category_board_title`, `category_board_id_position`, `category_board_text`, `category_board_id_parent`, `category_board_image`, `category_board_description`, `category_board_alias`, `category_board_count_view`, `category_board_date_view`, `category_board_price`, `category_board_count_free`, `category_board_status_paid`, `category_board_display_price`, `category_board_auction`, `category_board_secure`, `category_board_h1`, `category_board_auto_title`, `category_board_online_view`, `category_board_auto_title_template`, `category_board_show_index`, `category_board_marketplace`, `category_board_booking`, `category_board_booking_variant`, `category_board_variant_price_id`, `category_board_measures_price`, `category_board_rules`) VALUES
(277, 'Двери', 1, 'Двери', 236, '', 0, NULL, '', 'dveri', 0, '2020-10-12 19:15:12', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(278, 'Измерительные инструменты', 1, 'Измерительные инструменты', 237, '', 0, NULL, '', 'izmeritelnye-instrumenty', 0, '2020-10-12 19:15:19', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(279, 'Окна', 1, 'Окна', 238, '', 0, NULL, '', 'okna', 0, '2020-10-12 19:15:22', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(280, 'Отопление и вентиляция', 1, 'Отопление и вентиляция', 239, '', 0, NULL, '', 'otoplenie-i-ventilyaciya', 0, '2020-10-12 19:15:24', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(281, 'Потолки', 1, 'Потолки', 240, '', 0, NULL, '', 'potolki', 0, '2020-10-12 19:15:25', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(282, 'Ручные инструменты', 1, 'Ручные инструменты', 241, '', 0, NULL, '', 'ruchnye-instrumenty', 0, '2020-10-12 19:15:27', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(283, 'Сантехника и водоснабжение', 1, 'Сантехника и водоснабжение', 242, '', 0, NULL, '', 'santehnika-i-vodosnabzhenie', 0, '2020-10-12 19:15:30', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(284, 'Стройматериалы', 1, 'Стройматериалы', 243, '', 0, NULL, '', 'stroymaterialy', 0, '2020-10-12 19:15:32', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(285, 'Электрика', 1, 'Электрика', 244, '', 0, NULL, '', 'elektrika', 0, '2020-10-12 19:15:34', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(286, 'Электроинструменты', 1, 'Электроинструменты', 245, '', 0, NULL, '', 'elektroinstrumenty', 0, '2020-10-12 19:15:36', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(287, 'Другое', 1, 'Другое', 246, '', 0, NULL, '', 'drugoe', 0, '2020-10-12 19:15:38', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `uni_ads_filters`
--
ALTER TABLE `uni_ads_filters`
  ADD PRIMARY KEY (`ads_filters_id`);

--
-- Индексы таблицы `uni_ads_filters_alias`
--
ALTER TABLE `uni_ads_filters_alias`
  ADD PRIMARY KEY (`ads_filters_alias_id`);

--
-- Индексы таблицы `uni_ads_filters_category`
--
ALTER TABLE `uni_ads_filters_category`
  ADD PRIMARY KEY (`ads_filters_category_id`);

--
-- Индексы таблицы `uni_ads_filters_items`
--
ALTER TABLE `uni_ads_filters_items`
  ADD PRIMARY KEY (`ads_filters_items_id`),
  ADD KEY `id_filter` (`ads_filters_items_id_filter`);

--
-- Индексы таблицы `uni_category_board`
--
ALTER TABLE `uni_category_board`
  ADD PRIMARY KEY (`category_board_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `uni_ads_filters`
--
ALTER TABLE `uni_ads_filters`
  MODIFY `ads_filters_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=327;
--
-- AUTO_INCREMENT для таблицы `uni_ads_filters_alias`
--
ALTER TABLE `uni_ads_filters_alias`
  MODIFY `ads_filters_alias_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `uni_ads_filters_category`
--
ALTER TABLE `uni_ads_filters_category`
  MODIFY `ads_filters_category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1017;
--
-- AUTO_INCREMENT для таблицы `uni_ads_filters_items`
--
ALTER TABLE `uni_ads_filters_items`
  MODIFY `ads_filters_items_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6308;
--
-- AUTO_INCREMENT для таблицы `uni_category_board`
--
ALTER TABLE `uni_category_board`
  MODIFY `category_board_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=427;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
