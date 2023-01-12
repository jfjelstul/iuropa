# The iuropa package

An `R` package to access data from the IUROPA API. This package provides an easy-to-use R interface for the IUROPA API. This API provides access to the IUROPA CJEU Database, including the IUROPA CJEU Database Platform.

The IUROPA CJEU Database is the most complete collection of research-ready data about the Court of Justice of the European Union (CJEU) and European Union (EU) law.

At the core of the IUROPA CJEU Database is the IUROPA CJEU Database Platform, which includes data on the universe of CJEU cases, proceedings, decisions, and judges. It also includes data on judicial appointments, parties in CJEU proceedings, legal procedures and outcomes, the assignment of judges to decisions, observers in references for a preliminary ruling, and citations in decisions.

## About the IUROPA Project

The IUROPA Project (ius + Europa) is a multidisciplinary platform for research on judicial politics in the European Union (EU). The project brings together a network of scholars with a background in law and political science. The IUROPA Project studies the conditions for judicial independence and rule of law against the backdrop of ongoing developments with regards to the judicialization of politics (courts making decisions with political implications) and politicization of courts (efforts from political actors to influence courts).

A key feature of The IUROPA Project is the development of a comprehensive database with detailed information on cases and actors of the Court of Justice of the European Union: the IUROPA CJEU Database. The database includes information on the outcomes, processes and actors involved in the decision-making of the CJEU, compiled into a research-friendly format. The information has been collected from public sources and prepared and analyzed by means of automatic and manual coding.

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

> Joshua Fjelstul (2023). iuropa: An R Interface to IUROPA API. R package version 0.1.0.

The `BibTeX` entry for the package is:

```
@Manual{,
  title = {iuropa: An R Interface to the IUROPA API},
  author = {Joshua Fjelstul},
  year = {2023},
  note = {R package version 0.1.0},
}
```

If you use data from the CJEU Database Platform, please also cite the database and the paper that introduces the database.

The citation for the database is:

> Brekke, Stein Arne, Joshua Fjelstul, Silje Synnøve Lyder Hermansen, and Daniel Naurin. 2023. "The IUROPA CJEU Database Platform: Decisions and Decision-Makers" (Release 1.0), in Lindholm, Johan, Daniel Naurin, Urska Sadl, Anna Wallerman Ghavanini, Stein Arne Brekke, Joshua Fjelstul, Silje Synnøve Lyder Hermansen, Olof Larsson, Andreas Moberg, Moa Näsström, Michal Ovádek, Tommaso Pavone, and Philipp Schroeder, The IUROPA CJEU Database, The IUROPA Project, https://iuropa.pol.gu.se/.

The `BibTex` entry for the database is:

```
@incollection{CJEUDatabasePlatform,
  author = {Brekke, Stein Arne and Fjelstul, Joshua and Hermansen, Silje Synn{\o}ve
    Lyder and Naurin, Daniel},
  booktitle = {The IUROPA CJEU Database},
  editor = {Lindholm, Johan and Naurin, Daniel and {\v{S}}adl, Ur{\v{s}}ka and
    {Wallerman Ghavanini}, Anna and Brekke, Stein Arne and Fjelstul, Joshua and
    Hermansen, Silje Synn{\o}ve Lyder and Larsson, Olof and Moberg, Andreas and
    N{\"{a}}sstr{\"{o}}m, Moa and Ov{\'{a}}dek, Michal and Pavone, Tommaso and
    Schroeder, Philipp},
  publisher = {IUROPA},
  title = {{The IUROPA CJEU Database Platform: Decisions and Decision-Makers}},
  url = {http://iuropa.pol.gu.se},
  year = {2023}
}
```

The citation for the paper is:

> Stein Arne Brekke, Joshua C. Fjelstul, Silje Synnøve Lyder Hermansen, and Daniel Naurin. 2023. The CJEU Database Platform: Decisions and Decision-Makers. Journal of Law and Courts. Forthcoming.

The `BibTeX` entry for the paper is:

```
@article{CJEUDatabasePlatformArticle,
author = {Brekke, Stein Arne and Fjelstul, Joshua C. and Hermansen, Silje Synn{\o}ve Lyder and Naurin, Daniel},
title = {The CJEU Database Platform: Decisions and Decision-Makers},
journal = {Journal of Law and Courts}
year = {2023}
}
```

## Problems

If you notice an error in the data or a bug in the `R` package, please report it [here](https://github.com/jfjelstul/iuropa/issues).
