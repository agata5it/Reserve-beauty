-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Wrz 11, 2026 at 07:22 PM
-- Wersja serwera: 10.4.28-MariaDB
-- Wersja PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Reserve-beauty`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `dostepnosc_pracownikow`
--

CREATE TABLE `dostepnosc_pracownikow` (
  `id` int(11) NOT NULL,
  `id_pracownika` int(11) NOT NULL,
  `dzien_tygodnia` int(11) NOT NULL,
  `czas_rozpoczecia` time NOT NULL,
  `czas_zakonczenia` time NOT NULL
) ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `kategorie_uslug`
--

CREATE TABLE `kategorie_uslug` (
  `id` int(11) NOT NULL,
  `nazwa` varchar(150) NOT NULL,
  `opis` text DEFAULT NULL,
  `aktywny` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pracownicy`
--

CREATE TABLE `pracownicy` (
  `id_pracownika` int(11) NOT NULL,
  `id_uzytkownika` int(11) NOT NULL,
  `id_salonu` int(11) NOT NULL,
  `opis` text DEFAULT NULL,
  `aktywnosc` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pracownicy_uslugi`
--

CREATE TABLE `pracownicy_uslugi` (
  `id_pracownika` int(11) NOT NULL,
  `id_uslugi` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rezerwacje`
--

CREATE TABLE `rezerwacje` (
  `nr_rezerwacji` int(11) NOT NULL,
  `id_uzytkownika` int(11) NOT NULL,
  `id_pracownika` int(11) NOT NULL,
  `id_uslugi` int(11) NOT NULL,
  `data_rozpoczecia` datetime NOT NULL,
  `data_zakonczenia` datetime NOT NULL,
  `cena` decimal(10,2) NOT NULL,
  `status` enum('oczekujaca','potwierdzona','zrealizowana','anulowana') NOT NULL DEFAULT 'oczekujaca',
  `uwagi` text DEFAULT NULL,
  `utworzono_dnia` datetime NOT NULL DEFAULT current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `salony`
--

CREATE TABLE `salony` (
  `id_salonu` int(11) NOT NULL,
  `nazwa` varchar(100) NOT NULL,
  `opis` text DEFAULT NULL,
  `miasto` varchar(100) NOT NULL,
  `adres` varchar(200) NOT NULL,
  `aktywnosc` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uslugi`
--

CREATE TABLE `uslugi` (
  `id_uslugi` int(11) NOT NULL,
  `id_salonu` int(11) NOT NULL,
  `id_kategoria` int(11) NOT NULL,
  `nazwa` varchar(150) NOT NULL,
  `opis` text DEFAULT NULL,
  `czas_trwania` int(11) NOT NULL,
  `cena` decimal(10,2) NOT NULL,
  `aktywnosc` tinyint(1) NOT NULL DEFAULT 1
) ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uzytkownicy`
--

CREATE TABLE `uzytkownicy` (
  `id_uzytkownika` int(11) NOT NULL,
  `imie` varchar(100) NOT NULL,
  `nazwisko` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `haslo` varchar(255) NOT NULL,
  `telefon` varchar(20) NOT NULL,
  `rola` enum('klient','pracownik','admin') NOT NULL DEFAULT 'klient',
  `aktywny` tinyint(1) NOT NULL DEFAULT 1,
  `utworzono_dnia` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `dostepnosc_pracownikow`
--
ALTER TABLE `dostepnosc_pracownikow`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pracownika` (`id_pracownika`);

--
-- Indeksy dla tabeli `kategorie_uslug`
--
ALTER TABLE `kategorie_uslug`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nazwa` (`nazwa`);

--
-- Indeksy dla tabeli `pracownicy`
--
ALTER TABLE `pracownicy`
  ADD PRIMARY KEY (`id_pracownika`),
  ADD UNIQUE KEY `id_uzytkownika` (`id_uzytkownika`),
  ADD KEY `id_salonu` (`id_salonu`);

--
-- Indeksy dla tabeli `pracownicy_uslugi`
--
ALTER TABLE `pracownicy_uslugi`
  ADD PRIMARY KEY (`id_pracownika`,`id_uslugi`),
  ADD KEY `id_uslugi` (`id_uslugi`);

--
-- Indeksy dla tabeli `rezerwacje`
--
ALTER TABLE `rezerwacje`
  ADD PRIMARY KEY (`nr_rezerwacji`),
  ADD KEY `id_uzytkownika` (`id_uzytkownika`),
  ADD KEY `id_pracownika` (`id_pracownika`),
  ADD KEY `id_uslugi` (`id_uslugi`);

--
-- Indeksy dla tabeli `salony`
--
ALTER TABLE `salony`
  ADD PRIMARY KEY (`id_salonu`);

--
-- Indeksy dla tabeli `uslugi`
--
ALTER TABLE `uslugi`
  ADD PRIMARY KEY (`id_uslugi`),
  ADD KEY `id_salonu` (`id_salonu`),
  ADD KEY `id_kategoria` (`id_kategoria`);

--
-- Indeksy dla tabeli `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  ADD PRIMARY KEY (`id_uzytkownika`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dostepnosc_pracownikow`
--
ALTER TABLE `dostepnosc_pracownikow`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kategorie_uslug`
--
ALTER TABLE `kategorie_uslug`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pracownicy`
--
ALTER TABLE `pracownicy`
  MODIFY `id_pracownika` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rezerwacje`
--
ALTER TABLE `rezerwacje`
  MODIFY `nr_rezerwacji` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `salony`
--
ALTER TABLE `salony`
  MODIFY `id_salonu` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `uslugi`
--
ALTER TABLE `uslugi`
  MODIFY `id_uslugi` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  MODIFY `id_uzytkownika` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `dostepnosc_pracownikow`
--
ALTER TABLE `dostepnosc_pracownikow`
  ADD CONSTRAINT `dostepnosc_pracownikow_ibfk_1` FOREIGN KEY (`id_pracownika`) REFERENCES `pracownicy` (`id_pracownika`) ON DELETE CASCADE;

--
-- Constraints for table `pracownicy`
--
ALTER TABLE `pracownicy`
  ADD CONSTRAINT `pracownicy_ibfk_1` FOREIGN KEY (`id_uzytkownika`) REFERENCES `uzytkownicy` (`id_uzytkownika`) ON DELETE CASCADE,
  ADD CONSTRAINT `pracownicy_ibfk_2` FOREIGN KEY (`id_salonu`) REFERENCES `salony` (`id_salonu`) ON DELETE CASCADE;

--
-- Constraints for table `pracownicy_uslugi`
--
ALTER TABLE `pracownicy_uslugi`
  ADD CONSTRAINT `pracownicy_uslugi_ibfk_1` FOREIGN KEY (`id_pracownika`) REFERENCES `pracownicy` (`id_pracownika`) ON DELETE CASCADE,
  ADD CONSTRAINT `pracownicy_uslugi_ibfk_2` FOREIGN KEY (`id_uslugi`) REFERENCES `uslugi` (`id_uslugi`) ON DELETE CASCADE;

--
-- Constraints for table `rezerwacje`
--
ALTER TABLE `rezerwacje`
  ADD CONSTRAINT `rezerwacje_ibfk_1` FOREIGN KEY (`id_uzytkownika`) REFERENCES `uzytkownicy` (`id_uzytkownika`) ON DELETE CASCADE,
  ADD CONSTRAINT `rezerwacje_ibfk_2` FOREIGN KEY (`id_pracownika`) REFERENCES `pracownicy` (`id_pracownika`) ON DELETE CASCADE,
  ADD CONSTRAINT `rezerwacje_ibfk_3` FOREIGN KEY (`id_uslugi`) REFERENCES `uslugi` (`id_uslugi`);

--
-- Constraints for table `uslugi`
--
ALTER TABLE `uslugi`
  ADD CONSTRAINT `uslugi_ibfk_1` FOREIGN KEY (`id_salonu`) REFERENCES `salony` (`id_salonu`) ON DELETE CASCADE,
  ADD CONSTRAINT `uslugi_ibfk_2` FOREIGN KEY (`id_kategoria`) REFERENCES `kategorie_uslug` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
