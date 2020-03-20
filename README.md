# Miscellaneous
> For projets and other things that doesn't belong to others

+ sourcecode-postgres : An custom Postgresql image for our needs
+ configurations files to build the whole project ([see below](#how-to-build-project) )

## How to build project

Using [Docker Compose](https://docs.docker.com/compose/gettingstarted/) :

### For production
```
docker-compose up -d
```

### For testing 

Useful for instance to get feedbacks/reviews about the application with some real data : 

```
docker-compose -f docker-compose.yml -f docker-compose-test.yml up -d
```
