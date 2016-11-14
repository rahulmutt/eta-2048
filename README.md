# Eta 2048

This project is a adaption of [yampa-2048](https://github.com/ksaveljev/yampa-2048) for the Eta programming language. 

![eta-2048 preview](eta2048.gif)

## Prerequisites
- JDK 8
  - JavaFX must be installed in the home directory of the JDK.
    - If you're running Ubuntu OpenJDK, you'll have to do an [extra step](http://stackoverflow.com/questions/34243982/why-is-javafx-is-not-included-in-openjdk-8-on-ubuntu-wily-15-10):
      `sudo apt-get install openjfx`
- [Eta](https://github.com/typelead/eta) (On `master` branch)

## Running
```
$ cd eta-2048
$ epm install Yampa # First-time only
$ epm run
```

## Changes from Original
Gloss is replaced by manual FFI bindings to JavaFX that simulates just enough of the Gloss API to port this project. The upper bounds were also updated to account for the changes since the original program was written.

## Contact Us
If you face any trouble with this project, or you'd like to take this project further, please join us on [Gitter](https://gitter.im/typelead/eta) or [file an issue](https://github.com/rahulmutt/eta-2048/issues).
