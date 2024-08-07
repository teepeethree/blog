---
author: tpotts
pubDatetime: 2023-10-23T00:00:00Z
title: Zero Trust Architecture
slug: ex-zta
featured: true
draft: false
tags:
  - zero-trust-architecture
description: A pratical explanation
---

# Zero-Trust Architecture - A practical explanation

## The formal explanation:

- **Never Trust, Always Verify**: At its core, ZTA operates on the assumption that threats can exist both outside and inside the network. Every access request, regardless of where it's coming from, needs to be authenticated _and_ authorised.
- **Least Privilege Access**: Only grant the minimum necessary access to users and services to accomplish their tasks. This minimises the potential damage of a breach.
- **Micro-segmentation**: Networks are divided into smaller zones. Even if a hacker gains access to one zone, they would be isolated and unable to move to other parts of the network.
- **Continuous Authentication and Authorization**: Rather than a one-time verification, ZTA mandates that authentication and authorisation are continuous processes. If a user's or service's behavior suddenly changes, it can be flagged and access can be revoked.
- **Explicit Access Control**: Define precise rules about who can access what. This involves defining roles and permissions explicitly and not relying on broad or vague classifications.
- **End-to-end Encryption**: Data should be encrypted not only when it's "at rest" (stored) but also when it's "in transit" (being moved across the network).
- **Telemetry and Analytics**: Collect logs and telemetry data to monitor network activity. This data is invaluable for detecting suspicious activity and for post-incident analysis.

## From the NCSC (National Cyber Security Centre - UK Government Cybersecurity Agency):

Practical elements as identified by the NCSC:

- Single strong source of user identity
- User authentication
- Machine authentication
- Additional context, such as policy compliance and device health
- Authorisation policies to access an application
- Access control policies within an application
