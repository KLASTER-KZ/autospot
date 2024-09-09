-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Июл 18 2022 г., 22:36
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
(75, 'Порода', 1, 'select', 66, 1, 0, 'poroda', 1),
(76, 'Порода', 1, 'select', 67, 1, 0, 'poroda', 1),
(77, 'Вид птицы', 1, 'select', 68, 1, 0, 'vid-pticy', 1),
(78, 'Вид животного', 1, 'select', 69, 1, 0, 'vid-zhivotnogo', 1),
(79, 'Вид животного', 1, 'select', 70, 1, 0, 'vid-zhivotnogo', 1),
(80, 'Вид животного', 1, 'select', 71, 1, 0, 'vid-zhivotnogo', 1),
(81, 'Тип товара', 1, 'select', 72, 1, 0, 'tip-tovara', 1),
(82, 'Тип', 1, 'select', 73, 1, 0, 'tip', 1);

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
(735, 177, 75),
(736, 178, 76),
(737, 179, 77),
(738, 180, 78),
(739, 182, 79),
(740, 184, 80),
(741, 184, 81),
(742, 185, 82);

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
(485, 75, 'Акита', 0, 'akita', 0),
(486, 75, 'Аляскинский маламут', 0, 'alyaskinskiy-malamut', 0),
(487, 75, 'Американский бульдог', 0, 'amerikanskiy-buldog', 0),
(488, 75, 'Английский бульдог', 0, 'angliyskiy-buldog', 0),
(489, 75, 'Басенджи', 0, 'basendzhi', 0),
(490, 75, 'Бассет', 0, 'basset', 0),
(491, 75, 'Бельгийская овчарка', 0, 'belgiyskaya-ovcharka', 0),
(492, 75, 'Бельгийский гриффон', 0, 'belgiyskiy-griffon', 0),
(493, 75, 'Бернский зенненхунд', 0, 'bernskiy-zennenhund', 0),
(494, 75, 'Бивер', 0, 'biver', 0),
(495, 75, 'Бигль', 0, 'bigl', 0),
(496, 75, 'Бишон фризе', 0, 'bishon-frize', 0),
(497, 75, 'Бобтейл', 0, 'bobteyl', 0),
(498, 75, 'Боксер', 0, 'bokser', 0),
(499, 75, 'Болонка', 0, 'bolonka', 0),
(500, 75, 'Бриар', 0, 'briar', 0),
(501, 75, 'Брюссельский гриффон', 0, 'bryusselskiy-griffon', 0),
(502, 75, 'Бульмастиф', 0, 'bulmastif', 0),
(503, 75, 'Бультерьер', 0, 'bulterer', 0),
(504, 75, 'Бурбуль', 0, 'burbul', 0),
(505, 75, 'Вельштерьер', 0, 'velshterer', 0),
(506, 75, 'Вест-хайленд-уайт-терьер', 0, 'vest-haylend-uayt-terer', 0),
(507, 75, 'Восточноевропейская овчарка', 0, 'vostochnoevropeyskaya-ovcharka', 0),
(508, 75, 'Далматин', 0, 'dalmatin', 0),
(509, 75, 'Джек Рассел терьер', 0, 'dzhek-rassel-terer', 0),
(510, 75, 'Доберман', 0, 'doberman', 0),
(511, 75, 'Дог', 0, 'dog', 0),
(512, 75, 'Ирландский терьер', 0, 'irlandskiy-terer', 0),
(513, 75, 'Йоркширский терьер', 0, 'yorkshirskiy-terer', 0),
(514, 75, 'Кавказская овчарка', 0, 'kavkazskaya-ovcharka', 0),
(515, 75, 'Кане-корсо', 0, 'kane-korso', 0),
(516, 75, 'Керн-терьер', 0, 'kern-terer', 0),
(517, 75, 'Китайская хохлатая', 0, 'kitayskaya-hohlataya', 0),
(518, 75, 'Кокер-спаниель', 0, 'koker-spaniel', 0),
(519, 75, 'Колли', 0, 'kolli', 0),
(520, 75, 'Курцхаар', 0, 'kurchaar', 0),
(521, 75, 'Лабрадор', 0, 'labrador', 0),
(522, 75, 'Лайка', 0, 'layka', 0),
(523, 75, 'Левретка', 0, 'levretka', 0),
(524, 75, 'Леонбергер', 0, 'leonberger', 0),
(525, 75, 'Лхаса Апсо', 0, 'lhasa-apso', 0),
(526, 75, 'Мастиф', 0, 'mastif', 0),
(527, 75, 'Миттельшнауцер', 0, 'mittelshnaucer', 0),
(528, 75, 'Мопс', 0, 'mops', 0),
(529, 75, 'Московская сторожевая', 0, 'moskovskaya-storozhevaya', 0),
(530, 75, 'Немецкая овчарка', 0, 'nemeckaya-ovcharka', 0),
(531, 75, 'Норвич-терьер', 0, 'norvich-terer', 0),
(532, 75, 'Ньюфаундленд', 0, 'nyufaundlend', 0),
(533, 75, 'Овчарка', 0, 'ovcharka', 0),
(534, 75, 'Папийон', 0, 'papiyon', 0),
(535, 75, 'Пекинес', 0, 'pekines', 0),
(536, 75, 'Петербургская орхидея', 0, 'peterburgskaya-orhideya', 0),
(537, 75, 'Питбуль', 0, 'pitbul', 0),
(538, 75, 'Пойнтер', 0, 'poynter', 0),
(539, 75, 'Пти-брабансон', 0, 'pti-brabanson', 0),
(540, 75, 'Пудель', 0, 'pudel', 0),
(541, 75, 'Ретривер', 0, 'retriver', 0),
(542, 75, 'Ризеншнауцер', 0, 'rizenshnaucer', 0),
(543, 75, 'Родезийский риджбек', 0, 'rodeziyskiy-ridzhbek', 0),
(544, 75, 'Ротвейлер', 0, 'rotveyler', 0),
(545, 75, 'Русская борзая', 0, 'russkaya-borzaya', 0),
(546, 75, 'Самоедская собака', 0, 'samoedskaya-sobaka', 0),
(547, 75, 'Сенбернар', 0, 'senbernar', 0),
(548, 75, 'Сеттер', 0, 'setter', 0),
(549, 75, 'Сибирский хаски', 0, 'sibirskiy-haski', 0),
(550, 75, 'Скотч-терьер', 0, 'skotch-terer', 0),
(551, 75, 'Спаниель', 0, 'spaniel', 0),
(552, 75, 'Среднеазиатская овчарка', 0, 'sredneaziatskaya-ovcharka', 0),
(553, 75, 'Стаффордширский терьер', 0, 'staffordshirskiy-terer', 0),
(554, 75, 'Такса', 0, 'taksa', 0),
(555, 75, 'Той-пудель', 0, 'toy-pudel', 0),
(556, 75, 'Той-терьер', 0, 'toy-terer', 0),
(557, 75, 'Фландрский бувье', 0, 'flandrskiy-buve', 0),
(558, 75, 'Фокстерьер', 0, 'foksterer', 0),
(559, 75, 'Французская овчарка', 0, 'francuzskaya-ovcharka', 0),
(560, 75, 'Французский бульдог', 0, 'francuzskiy-buldog', 0),
(561, 75, 'Цвергпинчер', 0, 'cvergpincher', 0),
(562, 75, 'Цвергшнауцер', 0, 'cvergshnaucer', 0),
(563, 75, 'Чау-чау', 0, 'chau-chau', 0),
(564, 75, 'Чихуахуа', 0, 'chihuahua', 0),
(565, 75, 'Шарпей', 0, 'sharpey', 0),
(566, 75, 'Швейцарская овчарка', 0, 'shveycarskaya-ovcharka', 0),
(567, 75, 'Шелти', 0, 'shelti', 0),
(568, 75, 'Ши-тцу', 0, 'shi-tcu', 0),
(569, 75, 'Шпиц', 0, 'shpic', 0),
(570, 75, 'Эрдельтерьер', 0, 'erdelterer', 0),
(571, 75, 'Ягдтерьер', 0, 'yagdterer', 0),
(572, 75, 'Японский хин', 0, 'yaponskiy-hin', 0),
(573, 76, 'Абиссинская', 0, 'abissinskaya', 0),
(574, 76, 'Американский кёрл', 0, 'amerikanskiy-kerl', 0),
(575, 76, 'Балинез', 0, 'balinez', 0),
(576, 76, 'Бенгальская', 0, 'bengalskaya', 0),
(577, 76, 'Британская', 0, 'britanskaya', 0),
(578, 76, 'Бурманская', 0, 'burmanskaya', 0),
(579, 76, 'Девон-рекс', 0, 'devon-reks', 0),
(580, 76, 'Донской сфинкс', 0, 'donskoy-sfinks', 0),
(581, 76, 'Европейская', 0, 'evropeyskaya', 0),
(582, 76, 'Канадский сфинкс', 0, 'kanadskiy-sfinks', 0),
(583, 76, 'Корниш-рекс', 0, 'kornish-reks', 0),
(584, 76, 'Курильский бобтейл', 0, 'kurilskiy-bobteyl', 0),
(585, 76, 'Лаперм', 0, 'laperm', 0),
(586, 76, 'Манчкин', 0, 'manchkin', 0),
(587, 76, 'Мейн-кун', 0, 'meyn-kun', 0),
(588, 76, 'Меконгский бобтейл', 0, 'mekongskiy-bobteyl', 0),
(589, 76, 'Невская маскарадная', 0, 'nevskaya-maskaradnaya', 0),
(590, 76, 'Норвежская лесная', 0, 'norvezhskaya-lesnaya', 0),
(591, 76, 'Ориентальная', 0, 'orientalnaya', 0),
(592, 76, 'Оцикет', 0, 'ociket', 0),
(593, 76, 'Персидская', 0, 'persidskaya', 0),
(594, 76, 'Петерболд', 0, 'peterbold', 0),
(595, 76, 'Русская голубая', 0, 'russkaya-golubaya', 0),
(596, 76, 'Селкирк-рекс', 0, 'selkirk-reks', 0),
(597, 76, 'Сиамская', 0, 'siamskaya', 0),
(598, 76, 'Сингапурская', 0, 'singapurskaya', 0),
(599, 76, 'Сомалийская', 0, 'somaliyskaya', 0),
(600, 76, 'Тайская', 0, 'tayskaya', 0),
(601, 76, 'Турецкая ангора', 0, 'tureckaya-angora', 0),
(602, 76, 'Уральский рекс', 0, 'uralskiy-reks', 0),
(603, 76, 'Шотландская', 0, 'shotlandskaya', 0),
(604, 76, 'Экзотическая', 0, 'ekzoticheskaya', 0),
(605, 76, 'Японский бобтейл', 0, 'yaponskiy-bobteyl', 0),
(606, 76, 'Другая', 0, 'drugaya', 0),
(607, 77, 'Голуби', 0, 'golubi', 0),
(608, 77, 'Певчие', 0, 'pevchie', 0),
(609, 77, 'Попугаи', 0, 'popugai', 0),
(610, 77, 'С/х птицы', 0, 's-h-pticy', 0),
(611, 78, 'Кролики', 0, 'kroliki', 0),
(612, 78, 'Морские свинки', 0, 'morskie-svinki', 0),
(613, 78, 'Мыши и крысы', 0, 'myshi-i-krysy', 0),
(614, 78, 'Хомяки', 0, 'homyaki', 0),
(615, 78, 'Хорьки', 0, 'horki', 0),
(616, 78, 'Шиншиллы', 0, 'shinshilly', 0),
(617, 78, 'Другой', 0, 'drugoy', 0),
(618, 79, 'Козы', 0, 'kozy', 0),
(619, 79, 'Коровы и быки', 0, 'korovy-i-byki', 0),
(620, 79, 'Овцы и бараны', 0, 'ovcy-i-barany', 0),
(621, 79, 'Лошади', 0, 'loshadi', 0),
(622, 79, 'Свиньи', 0, 'svini', 0),
(623, 80, 'Собаки', 0, 'sobaki', 0),
(624, 80, 'Кошки', 0, 'koshki', 0),
(625, 80, 'Птицы', 0, 'pticy', 0),
(626, 80, 'Грызуны', 0, 'gryzuny', 0),
(627, 80, 'Рыбки', 0, 'rybki', 0),
(628, 80, 'Лошади', 0, 'loshadi', 0),
(629, 80, 'Рептилии', 0, 'reptilii', 0),
(630, 80, 'С/х животные', 0, 's-h-zhivotnye', 0),
(631, 81, 'Будки и вольеры', 0, 'budki-i-volery', 0),
(632, 81, 'Витамины и добавки', 0, 'vitaminy-i-dobavki', 0),
(633, 81, 'Игрушки', 0, 'igrushki', 0),
(634, 81, 'Инструменты для ухода', 0, 'instrumenty-dlya-uhoda', 0),
(635, 81, 'Клетки и переноски', 0, 'kletki-i-perenoski', 0),
(636, 81, 'Корма', 0, 'korma', 0),
(637, 81, 'Лежаки и домики', 0, 'lezhaki-i-domiki', 0),
(638, 81, 'Миски, кормушки, поилки', 0, 'miski-kormushki-poilki', 0),
(639, 81, 'Намордники', 0, 'namordniki', 0),
(640, 81, 'Одежда и обувь', 0, 'odezhda-i-obuv', 0),
(641, 81, 'От блох и клещей', 0, 'ot-bloh-i-kleshchey', 0),
(642, 81, 'Ошейники и поводки', 0, 'osheyniki-i-povodki', 0),
(643, 81, 'Туалет и наполнители', 0, 'tualet-i-napolniteli', 0),
(644, 82, 'Аквариумы', 0, 'akvariumy', 0),
(645, 82, 'Декор и растения', 0, 'dekor-i-rasteniya', 0),
(646, 82, 'Инвентарь для обслуживания', 0, 'inventar-dlya-obsluzhivaniya', 0),
(647, 82, 'Обогрев', 0, 'obogrev', 0),
(648, 82, 'Освещение', 0, 'osveshchenie', 0),
(649, 82, 'Террариумы', 0, 'terrariumy', 0),
(650, 82, 'Фильтры и аэрация', 0, 'filtry-i-aeraciya', 0);

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
(177, 'Собаки', 1, 'Собаки', 226, '', 0, NULL, '', 'sobaki', 0, '2020-10-12 18:58:39', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(178, 'Кошки', 1, 'Кошки', 227, '', 0, NULL, '', 'koshki', 0, '2020-10-12 18:58:42', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(179, 'Птицы', 1, 'Птицы', 228, '', 0, NULL, '', 'ptitsi', 0, '2020-10-12 18:58:43', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(180, 'Грызуны', 1, 'Грызуны', 229, '', 0, NULL, '', 'grizuni', 0, '2020-10-12 18:58:45', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(181, 'Рыбки', 1, 'Рыбки', 230, '', 0, NULL, '', 'ribki', 0, '2020-10-12 18:58:46', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(182, 'С/х животные', 1, 'С/х животные', 231, '', 0, NULL, '', 's-h-zhivotnie', 0, '2020-10-12 18:58:48', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(183, 'Другие животные', 1, 'Другие животные', 232, '', 0, NULL, '', 'drugie-zhivotnie', 0, '2020-10-12 18:58:50', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(184, 'Товары для животных', 1, 'Товары для животных', 233, '', 0, NULL, '', 'tovari-dlya-zhivotnih', 0, '2020-10-12 18:58:51', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(185, 'Аквариумистика', 1, 'Аквариумистика', 234, '', 0, NULL, '', 'akvariumistika', 0, '2020-10-12 18:58:53', 0, 0, 0, 1, 0, 1, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL);

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
