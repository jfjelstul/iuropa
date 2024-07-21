# The iuropa package

An `R` package to access data from the IUROPA API. This package provides an easy-to-use R interface for the IUROPA API. This API provides access to the IUROPA CJEU Database, including the IUROPA CJEU Database Platform.

The IUROPA CJEU Database is the most complete collection of research-ready data about the Court of Justice of the European Union (CJEU) and European Union (EU) law.

At the core of the IUROPA CJEU Database is the IUROPA CJEU Database Platform, which includes data on the universe of CJEU cases, proceedings, decisions, and judges. It also includes data on judicial appointments, parties in CJEU proceedings, legal procedures and outcomes, the assignment of judges to decisions, observers in references for a preliminary ruling, and citations in decisions.

## About the IUROPA Project

IUROPA (ius + Europe) is a multidisciplinary platform for empirical legal studies of the European Union (EU). It brings together a network of scholars with backgrounds in law and political science who share an interest in research on law and politics related to the Court of Justice of the European Union (CJEU).

A key feature of IUROPA is the development of a comprehensive, reliable, and updated database with detailed information on cases, judgements, and actors involved in the judicial processes of the CJEU: The IUROPA CJEU Database.

The database currently includes six components, with data tables on cases, proceedings, decisions, judges, positions, national courts, and more. The information has been collected from public sources (EUR-Lex, InfoCuria, and the CJEU Registry), cross-validated, and corrected when necessary. The database include information derived from manual coding and includes reliability reports.

The IUROPA Project is financed by the Swedish Research Council (2018-04215), the Norwegian Research Council (223274, PluriCourts), and the European University Institute Research Council (2018-2020).

You can learn more about The IUROPA Project on [our website](https://iuropa.pol.gu.se/).

## Installation

You can install the latest development version of the `iuropa` package from GitHub:

```{r, eval=FALSE}
# install.packages("devtools")
devtools::install_github("jfjelstul/iuropa")
```

## Citation

If you use data from the `iuropa` package in a project or paper, please cite the package.

The citation for the package is:

> Joshua Fjelstul (2024). iuropa: An R Interface to IUROPA API. R package version 0.2.0.

The `BibTeX` entry for the package is:

```
@Manual{,
  title = {iuropa: An R Interface to the IUROPA API},
  author = {Joshua Fjelstul},
  year = {2024},
  note = {R package version 0.2.0},
}
```

If you use data from the CJEU Database Platform, please also cite the database and the article that introduces the database.

The citation for the database is:

> Fjelstul, Joshua, Daniel Naurin, Stein Arne Brekke, and Silje Synnøve Lyder Hermansen. 2024. "The IUROPA CJEU Database Platform (v2.00.00)", in Lindholm, Johan, Daniel Naurin, Urska Sadl, Anna Wallerman Ghavanini, Stein Arne Brekke, Joshua Fjelstul, Silje Synnøve Lyder Hermansen, Olof Larsson, Andreas Moberg, Moa Näsström, Michal Ovádek, Tommaso Pavone, and Philipp Schroeder, The Court of Justice of the European Union (CJEU) Database, IUROPA, https://www.iuropa.pol.gu.se/.

The `BibTex` entry for the database is:

```
@incollection{CJEU_Database_Platform,
  author = {Fjelstul, Joshua and Naurin, Daniel and Brekke, Stein Arne and Hermansen, Silje Synn{\o}ve Lyder},
  booktitle = {The IUROPA CJEU Database},
  editor = {Lindholm, Johan and Naurin, Daniel and {\v{S}}adl, Ur{\v{s}}ka and Wallerman Ghavanini, Anna and Brekke, Stein Arne and Fjelstul, Joshua and Hermansen, Silje Synn{\o}ve Lyder     and Larsson, Olof and Moberg, Andreas and N{\"{a}}sstr{\"{o}}m, Moa and Ov{\'{a}}dek, Michal and Pavone, Tommaso and Schroeder, Philipp},
    publisher = {The IUROPA Project},
  title = {The IUROPA CJEU Database Platform (v2.00.00)},
  url = {https://www.iuropa.pol.gu.se},
  year = {2024}
}
```

The citation for the article is:

> Brekke, Stein Arne, Joshua C. Fjelstul, Silje Synnøve Lyder Hermansen, and Daniel Naurin. 2023. "The CJEU Database Platform: Decisions and Decision-Makers." Journal of Law and Courts 11(2): 389-410. https://doi.org/10.1017/jlc.2022.3.

The `BibTeX` entry for the article is:

```
@article{Brekke_Fjelstul_Hermansen_Naurin_2023,
  author = {Brekke, Stein Arne and Fjelstul, Joshua C. and Hermansen, Silje Synn{\o}ve Lyder and Naurin, Daniel},
  title = {The CJEU Database Platform: Decisions and Decision-Makers},
  journal = {Journal of Law and Courts},
  year = {2023},
  volume={11},
  number={2},
  pages={389-410},
  DOI={10.1017/jlc.2022.3}
}
```

## Problems

If you notice an error in the data or a bug in the `R` package, please report it [here](https://github.com/jfjelstul/iuropa/issues).
