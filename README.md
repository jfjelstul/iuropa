# The iuropa package

An `R` package to access data from the IUROPA API. This package provides an easy-to-use R interface for the IUROPA API. This API provides access to the IUROPA CJEU Database Platform.

The CJEU Database Platform is the largest and most comprehensive research-oriented database on the CJEU. It includes data on CJEU cases, decisions, and judges collected from the official register of the Court, InfoCuria (the Court's official database), and EUR-Lex (the EU's official database of legal documents). All of the data has been cleaned and cross-validated and is research-ready.

The database contains eight datasets that cover CJEU cases, the parties in each case, CJEU decisions (e.g., judgments, orders, Advocate General opinions, etc.), the judges that participated in each decision, the legal procedures associated with each decision (e.g., references for a preliminary ruling, actions for annulment, appeals, etc.), submissions of observations and interventions with respect to each decision, citations to other EU legal documents in each decision, and CJEU judges and Advocates General.

## About the IUROPA Project

The IUROPA Project (ius + Europa) is a multidisciplinary platform for research on judicial politics in the European Union (EU). The project brings together a network of scholars with a background in law and political science. IUROPA studies the conditions for judicial independence and rule of law against the backdrop of ongoing developments with regards to the judicialization of politics (courts making decisions with political implications) and politicization of courts (efforts from political actors to influence courts).

A key feature of IUROPA is the development of a comprehensive database with detailed information on cases and actors of the Court of Justice of the European Union: The CJEU Database. The database includes information on the outcomes, processes and actors involved in the decision-making of the CJEU, compiled into a research-friendly format. The information has been collected from public sources and prepared and analyzed by means of automatic and manual coding.

You can learn more about the IUROPA Project on [our website](http://iuropa.pol.gu.se/).

## Installation

You can install the latest development version of the `iuropa` package from GitHub:

```{r, eval=FALSE}
# install.packages("devtools")
devtools::install_github("jfjelstul/iuropa")
```

## Citation

If you use data from the `iuropa` package in a project or paper, please cite the package.

The citation for the package is:

> Joshua Fjelstul (2021). iuropa: An R Interface to IUROPA API. R package version 0.1.0.

The `BibTeX` entry for the package is:

```
@Manual{,
  title = {iuropa: An R Interface to the IUROPA API},
  author = {Joshua Fjelstul},
  year = {2022},
  note = {R package version 0.1.0},
}
```

If you use data from the CJEU Database Platform, please also cite the database and the paper that introduces the database.

The citation for the database is:

> Brekke, Stein Arne, Joshua Fjelstul, Silje Synnøve Lyder Hermansen and Daniel Naurin. 2021. "The CJEU Database Platform: Decisions and Decision-Makers" (Stable Release 0.1), in Lindholm, Johan, Daniel Naurin, Urska Sadl, Anna Wallerman Ghavanini, Stein Arne Brekke, Joshua Fjelstul, Silje Synnøve Lyder Hermansen, Olof Larsson, Andreas Moberg, Moa Näsström, Michal Ovádek, Tommaso Pavone, and Philipp Schroeder, The Court of Justice of the European Union Database, IUROPA, URL: http://iuropa.pol.gu.se/.

The `BibTex` entry for the database is:

```
@incollection{CJEUDatabasePlatform,
  author = {Brekke, Stein Arne and Fjelstul, Joshua and Hermansen, Silje Synn{\o}ve
    Lyder and Naurin, Daniel},
  booktitle = {The Court of Justice of the European Union Database},
  editor = {Lindholm, Johan and Naurin, Daniel and {\v{S}}adl, Ur{\v{s}}ka and
    {Wallerman Ghavanini}, Anna and Brekke, Stein Arne and Fjelstul, Joshua and
    Hermansen, Silje Synn{\o}ve Lyder and Larsson, Olof and Moberg, Andreas and
    N{\"{a}}sstr{\"{o}}m, Moa and Ov{\'{a}}dek, Michal and Pavone, Tommaso and
    Schroeder, Philipp},
  publisher = {IUROPA},
  title = {{The CJEU Database Platform: Decisions and Decision-Makers}},
  url = {http://iuropa.pol.gu.se},
  year = {2021}
}
```

The citation for the paper is:

> Stein Arne Brekke, Joshua C. Fjelstul, Silje Synnøve Lyder Hermansen, and Daniel Naurin. 2021. The CJEU Database Platform: Decisions and Decision-Makers. Working paper.

The `BibTeX` entry for the paper is:

```
@unpublished{CJEUDatabasePlatformPaper,
  author = {Brekke, Stein Arne and Fjelstul, Joshua C. and Hermansen, Silje Synn{\o}ve
    Lyder and Naurin, Daniel},
  title = {{The CJEU Database Platform: Decisions and Decision-Makers}},
  year = {2021}
}
```

## Problems

If you notice an error in the data or a bug in the `R` package, please report it [here](https://github.com/jfjelstul/iuropa/issues).
