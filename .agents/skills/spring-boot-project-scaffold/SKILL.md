---
name: spring-boot-project-scaffold
description: Scaffolds a new Spring Boot service in Kotlin with Gradle Kotlin DSL, YAML config, Jib and Actuator, always at current Spring Boot and Kotlin versions. Use when creating or initializing a Spring Boot project, or when adding its build and configuration files.
---

# Spring Boot Project Scaffold

Produces a runnable Kotlin service matching the author's standing preferences. Every version comes from start.spring.io at scaffold time: nothing here pins one, so the skill cannot go stale. New projects track the latest Spring Boot, Kotlin and Gradle; a hand-pinned Kotlin/Boot pairing is the usual way scaffolding breaks.

## Steps

### 1. Generate from start.spring.io

```sh
curl -sSL "https://start.spring.io/starter.zip?type=gradle-project-kotlin&language=kotlin&javaVersion=21&dependencies=web,actuator,devtools,docker-compose&name=<name>&groupId=<group>&packageName=<package>" -o starter.zip
mkdir -p <target> && unzip -q starter.zip -d <target>
```

Omit `bootVersion`: the default is the latest GA, and the generator picks a Kotlin version that Boot supports. The wrapper it ships is current, so leave it alone.

Done when `./gradlew build` succeeds in the extracted project and `gradlew` plus `gradle/wrapper/` exist.

The generator already delivers the current shape, so add nothing below by hand without diffing against it:

| Generated | Note |
|---|---|
| `spring-boot-starter-webmvc` | Boot 4 renamed `-web` |
| `spring-boot-starter-webmvc-test`, `spring-boot-starter-actuator-test` | Boot 4 split the monolithic test starter |
| `tools.jackson.module:jackson-module-kotlin` | Jackson 3, package `tools.jackson.*` |
| `-Xjsr305=strict`, `-Xannotation-default-target=param-property` | Boot 4's Kotlin defaults |
| `developmentOnly` devtools and docker-compose | Never in the runtime classpath |

### 2. Move configuration to YAML

Replace `src/main/resources/application*.properties` with `application.yml`, plus `application-<profile>.yml` per profile.

Done when no `.properties` file remains under `src/main/resources` or `src/test/resources`.

```yaml
spring:
  application:
    name: <name>

management:
  endpoints:
    web:
      exposure:
        include: health,info
```

Leave `management.endpoint.health.show-details` unset: the default hides details, and `when-authorized` shows nothing to anyone until the service has a Spring Security filter chain.

### 3. Add Jib

```kotlin
plugins {
    // keep the generated plugins
    id("com.google.cloud.tools.jib") version "3.5.4"
}

jib {
    from { image = "eclipse-temurin:21-jre-alpine" }
    to { image = "<registry>/<org>/<name>:${project.version}" }
    container { ports = listOf("8080") }
}
```

Read the plugin version from <https://plugins.gradle.org/plugin/com.google.cloud.tools.jib> while scaffolding; the number above is only the current one at the time of writing. Make `to.image` registry-qualified, otherwise it only works for `jibBuildTar`.

Jib builds from `runtimeClasspath`, which excludes `developmentOnly`, so devtools and docker-compose never reach the image. No Dockerfile.

Done when `./gradlew jibBuildTar` succeeds.

## Verification

Run every check before reporting the project set up:

1. `./gradlew test` is green, and every Gradle command went through the wrapper.
2. No `.properties` files under `src/main/resources` or `src/test/resources`.
3. `/actuator/health` and `/actuator/info` respond over HTTP.
4. `./gradlew jibBuildTar` succeeds and the project has no Dockerfile.
5. All application, configuration and test code is Kotlin, and Jackson imports are `tools.jackson.*`.

## Scope

This targets new projects on the current Spring Boot, where Jackson 3 (`tools.jackson`) is the only option. A project pinned to Boot 3.x keeps `com.fasterxml.jackson`; scaffold with `bootVersion` set to that line instead of applying the table above.
