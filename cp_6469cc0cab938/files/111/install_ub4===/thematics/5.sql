-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Июл 18 2022 г., 22:32
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
(1, 'Тип', 1, 'select', 1, 1, 0, 'tip', 1),
(2, 'Тип', 1, 'select', 2, 1, 0, 'tip', 1),
(3, 'Тип', 1, 'select', 3, 1, 0, 'tip', 1),
(4, 'Тип', 1, 'select', 4, 1, 0, 'tip', 1),
(5, 'Тип', 1, 'select', 5, 1, 0, 'tip', 1),
(6, 'Тип', 1, 'select', 6, 1, 0, 'tip', 1),
(7, 'Тип', 1, 'select', 7, 1, 0, 'tip', 1),
(8, 'Тип', 1, 'select', 8, 1, 0, 'tip', 1),
(9, 'Тип', 1, 'select', 9, 1, 0, 'tip', 1),
(10, 'Тип', 1, 'select', 10, 1, 0, 'tip', 1),
(11, 'Тип', 1, 'select', 11, 1, 0, 'tip', 1),
(12, 'Тип', 1, 'select', 12, 1, 0, 'tip', 1),
(13, 'Тип', 1, 'select', 13, 1, 0, 'tip', 1),
(14, 'Тип', 1, 'select', 14, 1, 0, 'tip', 1);

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
(1, 2, 1),
(2, 3, 2),
(3, 4, 3),
(4, 5, 4),
(5, 6, 5),
(6, 7, 6),
(7, 9, 7),
(8, 10, 8),
(9, 11, 9),
(10, 13, 10),
(11, 14, 11),
(12, 15, 12),
(13, 17, 13),
(14, 19, 14);

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
(1, 1, 'Баки, канистры', 0, 'baki-kanistry', 0),
(2, 1, 'Бойлеры, нагреватели', 0, 'boylery-nagrevateli', 0),
(3, 1, 'Внешние люки', 0, 'vneshnie-lyuki', 0),
(4, 1, 'Заливные горловины, крышки', 0, 'zalivnye-gorloviny-kryshki', 0),
(5, 1, 'Краны, душевые лейки', 0, 'krany-dushevye-leyki', 0),
(6, 1, 'Мойки, поддоны', 0, 'moyki-poddony', 0),
(7, 1, 'Насосы, помпы', 0, 'nasosy-pompy', 0),
(8, 1, 'Слив', 0, 'sliv', 0),
(9, 1, 'Шланги, соединения', 0, 'shlangi-soedineniya', 0),
(10, 2, 'Выхлоп', 0, 'vyhlop', 0),
(11, 2, 'Газовые баллоны', 0, 'gazovye-ballony', 0),
(12, 2, 'Газовые шланги', 0, 'gazovye-shlangi', 0),
(13, 2, 'Гофра', 0, 'gofra', 0),
(14, 2, 'Гриль, аксессуары', 0, 'gril-aksessuary', 0),
(15, 2, 'Датчики, сигнализаторы, защита', 0, 'datchiki-signalizatory-zashchita', 0),
(16, 2, 'Камины, пушки, обогреватели', 0, 'kaminy-pushki-obogrevateli', 0),
(17, 2, 'Кухонные вытяжки', 0, 'kuhonnye-vytyazhki', 0),
(18, 2, 'Люки газоснабжения', 0, 'lyuki-gazosnabzheniya', 0),
(19, 2, 'Печки, нагреватели, отопитель', 0, 'pechki-nagrevateli-otopitel', 0),
(20, 2, 'Плиты, духовки, горелки', 0, 'plity-duhovki-gorelki', 0),
(21, 2, 'Редукторы', 0, 'reduktory', 0),
(22, 2, 'Тройники, фитинги, отводы', 0, 'troyniki-fitingi-otvody', 0),
(23, 3, 'Аккумуляторы, зарядные', 0, 'akkumulyatory-zaryadnye', 0),
(24, 3, 'Внешние розетки, коннекторы', 0, 'vneshnie-rozetki-konnektory', 0),
(25, 3, 'Лампочки, предохранители', 0, 'lampochki-predohraniteli', 0),
(26, 3, 'Переходники, удлинители', 0, 'perehodniki-udliniteli', 0),
(27, 3, 'Плафоны, габариты', 0, 'plafony-gabarity', 0),
(28, 3, 'Розетки, выключатели, коннекторы', 0, 'rozetki-vyklyuchateli-konnektory', 0),
(29, 3, 'Светильники, люстры', 0, 'svetilniki-lyustry', 0),
(30, 3, 'Штекеры, переходники ТСУ', 0, 'shtekery-perehodniki-tsu', 0),
(31, 3, 'Электроблоки, панели управления', 0, 'elektrobloki-paneli-upravleniya', 0),
(32, 4, 'Вентиляторы для люков', 0, 'ventilyatory-dlya-lyukov', 0),
(33, 4, 'Внешние люки', 0, 'vneshnie-lyuki', 0),
(34, 4, 'Запчасти для люков', 0, 'zapchasti-dlya-lyukov', 0),
(35, 4, 'Крышки люков', 0, 'kryshki-lyukov', 0),
(36, 4, 'Люки', 0, 'lyuki', 0),
(37, 4, 'Шторки для люков', 0, 'shtorki-dlya-lyukov', 0),
(38, 5, 'Автомобильные шторки', 0, 'avtomobilnye-shtorki', 0),
(39, 5, 'Защелки/фиксаторы', 0, 'zashchelki-fiksatory', 0),
(40, 5, 'Маркизы для окон', 0, 'markizy-dlya-okon', 0),
(41, 5, 'Окна', 0, 'okna', 0),
(42, 5, 'Упоры для окон', 0, 'upory-dlya-okon', 0),
(43, 5, 'Шторки для окон', 0, 'shtorki-dlya-okon', 0),
(44, 6, 'Печки, болеры, отопители', 0, 'pechki-bolery-otopiteli', 0),
(45, 6, 'Вентиляционные решетки', 0, 'ventilyacionnye-reshetki', 0),
(46, 6, 'Гофра', 0, 'gofra', 0),
(47, 6, 'Камины, пушки, обогреватели', 0, 'kaminy-pushki-obogrevateli', 0),
(48, 6, 'Кондиционеры накрышные', 0, 'kondicionery-nakryshnye', 0),
(49, 6, 'Тройники, отводы, фитинги', 0, 'troyniki-otvody-fitingi', 0),
(50, 7, 'Домкраты', 0, 'domkraty', 0),
(51, 7, 'Опоры для автодомов', 0, 'opory-dlya-avtodomov', 0),
(52, 7, 'Опоры для прицеп дач', 0, 'opory-dlya-pricep-dach', 0),
(53, 7, 'Опоры универсальные', 0, 'opory-universalnye', 0),
(54, 8, 'Амортизаторы', 0, 'amortizatory', 0),
(55, 8, 'Мувер', 0, 'muver', 0),
(56, 8, 'Пневмоподвеска', 0, 'pnevmopodveska', 0),
(57, 8, 'Проставки', 0, 'prostavki', 0),
(58, 8, 'Тормозная система', 0, 'tormoznaya-sistema', 0),
(59, 9, 'Зимние чехлы', 0, 'zimnie-chehly', 0),
(60, 9, 'Навесы и чехлы для прицеп-дач', 0, 'navesy-i-chehly-dlya-pricep-dach', 0),
(61, 9, 'Солнцезащитные чехлы', 0, 'solncezashchitnye-chehly', 0),
(62, 9, 'Термо накидки', 0, 'termo-nakidki', 0),
(63, 9, 'Чехлы для автодомов', 0, 'chehly-dlya-avtodomov', 0),
(64, 9, 'Чехлы для кемперов', 0, 'chehly-dlya-kemperov', 0),
(65, 10, 'Аксессуары для биотуалетов', 0, 'aksessuary-dlya-biotualetov', 0),
(66, 10, 'Запчасти для биотуалетов', 0, 'zapchasti-dlya-biotualetov', 0),
(67, 10, 'Кассеты для туалетов', 0, 'kassety-dlya-tualetov', 0),
(68, 10, 'Туалеты переносные', 0, 'tualety-perenosnye', 0),
(69, 10, 'Туалеты стационарные', 0, 'tualety-stacionarnye', 0),
(70, 10, 'Химия для биотуалетов', 0, 'himiya-dlya-biotualetov', 0),
(71, 11, 'Аксессуары для велобагажников', 0, 'aksessuary-dlya-velobagazhnikov', 0),
(72, 11, 'Боксы', 0, 'boksy', 0),
(73, 11, 'Велокрепления', 0, 'velokrepleniya', 0),
(74, 11, 'Запчасти для велобагажников', 0, 'zapchasti-dlya-velobagazhnikov', 0),
(75, 11, 'Крепёжные ремни и троссы', 0, 'krepezhnye-remni-i-trossy', 0),
(76, 11, 'Лестницы', 0, 'lestnicy', 0),
(77, 11, 'Мотобагажники', 0, 'motobagazhniki', 0),
(78, 11, 'Наезды', 0, 'naezdy', 0),
(79, 11, 'Предупреждающие знаки', 0, 'preduprezhdayushchie-znaki', 0),
(80, 11, 'Рейлинги', 0, 'reylingi', 0),
(81, 11, 'Чехлы для велосипедов', 0, 'chehly-dlya-velosipedov', 0),
(82, 12, 'Зеркала EMUK', 0, 'zerkala-emuk', 0),
(83, 12, 'Зеркала Oppi', 0, 'zerkala-oppi', 0),
(84, 12, 'Зеркала для Fiat Ducato', 0, 'zerkala-dlya-fiat-ducato', 0),
(85, 12, 'Сумки для зеркал', 0, 'sumki-dlya-zerkal', 0),
(86, 12, 'Широкоугольные линзы', 0, 'shirokougolnye-linzy', 0),
(87, 13, 'Блокировка колес', 0, 'blokirovka-koles', 0),
(88, 13, 'Датчики давления колес', 0, 'datchiki-davleniya-koles', 0),
(89, 13, 'Диски', 0, 'diski', 0),
(90, 13, 'Колеса', 0, 'kolesa', 0),
(91, 13, 'Компрессоры, насосы, ремонт шин', 0, 'kompressory-nasosy-remont-shin', 0),
(92, 13, 'Крепление запаски', 0, 'kreplenie-zapaski', 0),
(93, 13, 'Крышки для колёс', 0, 'kryshki-dlya-koles', 0),
(94, 13, 'Чехлы для колес', 0, 'chehly-dlya-koles', 0),
(95, 14, 'Датчики парковки', 0, 'datchiki-parkovki', 0),
(96, 14, 'Дополнительные замки', 0, 'dopolnitelnye-zamki', 0),
(97, 14, 'Знаки, cпецсредства, наклейки', 0, 'znaki-cpecsredstva-nakleyki', 0),
(98, 14, 'Огнетушители', 0, 'ognetushiteli', 0),
(99, 14, 'Охранная сигнализация', 0, 'ohrannaya-signalizaciya', 0),
(100, 14, 'Пожарная сигнализация', 0, 'pozharnaya-signalizaciya', 0),
(101, 14, 'Сейфы', 0, 'seyfy', 0),
(102, 14, 'Сигнализаторы газов', 0, 'signalizatory-gazov', 0);

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
(1, 'Автодома', 1, 'Автодома', 0, '', 0, NULL, '', 'avtodoma', 0, '2020-10-12 17:25:18', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(2, 'Водоснабжение', 1, 'Водоснабжение', 0, '', 0, NULL, '', 'vodosnabzhenie', 0, '2020-10-12 17:25:33', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(3, 'Газоснабжение', 1, 'Газоснабжение', 0, '', 0, NULL, '', 'gazosnabzhenie', 0, '2020-10-12 17:25:45', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(4, 'Электрика', 1, 'Электрика', 0, '', 0, NULL, '', 'elektrika', 0, '2020-10-12 17:25:58', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(5, 'Люки', 1, 'Люки', 0, '', 0, NULL, '', 'lyuki', 0, '2020-10-12 17:26:09', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(6, 'Окна, шторки, фиксаторы', 1, 'Окна, шторки, фиксаторы', 0, '', 0, NULL, '', 'okna-shtorki-fiksatory', 0, '2020-10-12 17:26:20', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(7, 'Отопление, Кондиционирование', 1, 'Отопление, Кондиционирование', 0, '', 0, NULL, '', 'otoplenie-kondicionirovanie', 0, '2020-10-12 17:26:32', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(8, 'Мультимедия, антенны, ТВ', 1, 'Мультимедия, антенны, ТВ', 0, '', 0, NULL, '', 'multimediya-antenny-tv', 0, '2020-10-12 17:26:43', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(9, 'Опоры, домкраты, подставки', 1, 'Опоры, домкраты, подставки', 0, '', 0, NULL, '', 'opory-domkraty-podstavki', 0, '2020-10-12 17:26:55', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(10, 'Подвеска, пневмо, мувер, амортизатор', 1, 'Подвеска, пневмо, мувер, амортизатор', 0, '', 0, NULL, '', 'podveska-pnevmo-muver-amortizator', 0, '2020-10-12 17:27:05', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(11, 'Накидки, чехлы, навесы', 1, 'Накидки, чехлы, навесы', 0, '', 0, NULL, '', 'nakidki-chehly-navesy', 0, '2020-10-12 17:27:17', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(12, 'Автомобильные кресла и аксессуары', 1, 'Автомобильные кресла и аксессуары', 0, '', 0, NULL, '', 'avtomobilnye-kresla-i-aksessuary', 0, '2020-10-12 17:27:30', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(13, 'Биотуалеты, химия, кассеты', 1, 'Биотуалеты, химия, кассеты', 0, '', 0, NULL, '', 'biotualety-himiya-kassety', 0, '2020-10-12 17:27:41', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(14, 'Велокрепления, боксы, лестницы, рейлинги', 1, 'Велокрепления, боксы, лестницы, рейлинги', 0, '', 0, NULL, '', 'velokrepleniya-boksy-lestnicy-reylingi', 0, '2020-10-12 17:27:52', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(15, 'Зеркала заднего вида', 1, 'Зеркала заднего вида', 0, '', 0, NULL, '', 'zerkala-zadnego-vida', 0, '2020-10-12 17:28:05', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(16, 'Кемпинговая мебель', 1, 'Кемпинговая мебель', 0, '', 0, NULL, '', 'kempingovaya-mebel', 0, '2020-10-12 17:28:37', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(17, 'Колеса, диски, блокировки', 1, 'Колеса, диски, блокировки', 0, '', 0, NULL, '', 'kolesa-diski-blokirovki', 0, '2020-10-12 17:28:49', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(18, 'Предпалатки, палатки, тенты', 1, 'Предпалатки, палатки, тенты', 0, '', 0, NULL, '', 'predpalatki-palatki-tenty', 0, '2020-10-12 17:29:16', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(19, 'Сигнализация, замки, cейфы, знаки', 1, 'Сигнализация, замки, cейфы, знаки', 0, '', 0, NULL, '', 'signalizaciya-zamki-ceyfy-znaki', 0, '2020-10-12 17:29:28', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(20, 'Ступеньки, клинья, подставки', 1, 'Ступеньки, клинья, подставки', 0, '', 0, NULL, '', 'stupenki-klinya-podstavki', 0, '2020-10-12 17:29:42', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(21, 'Шасси, сцепное, фаркопы', 1, 'Шасси, сцепное, фаркопы', 0, '', 0, NULL, '', 'shassi-scepnoe-farkopy', 0, '2020-10-12 17:29:58', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL);

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
  MODIFY `ads_filters_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT для таблицы `uni_ads_filters_alias`
--
ALTER TABLE `uni_ads_filters_alias`
  MODIFY `ads_filters_alias_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `uni_ads_filters_category`
--
ALTER TABLE `uni_ads_filters_category`
  MODIFY `ads_filters_category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT для таблицы `uni_ads_filters_items`
--
ALTER TABLE `uni_ads_filters_items`
  MODIFY `ads_filters_items_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;
--
-- AUTO_INCREMENT для таблицы `uni_category_board`
--
ALTER TABLE `uni_category_board`
  MODIFY `category_board_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
