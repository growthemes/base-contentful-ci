# Project name

A short introduction to your project could go here. This README outlines the details of collaborating on this Grow website.

## Prerequisites

At a minimum, you will need the following tools installed:

1. [Git](http://git-scm.com/)
2. [Grow](https://grow.io)

If you do not have Grow, you can install it using:

```
curl https://install.growsdk.org | bash
```

## Running the development server

Prior to starting the development server, you may have to install dependencies used by your project. The `grow install` command walks you through this and tries to set up your environment for you.

The `grow run` command starts your development server. You can make changes to your project files and refresh to see them reflected immediately.

```
grow install
grow run
```

## Building

You can use the `grow build` command to build your whole site to the `build` directory. This is a good way to test and verify the generated code.

```
grow build
```

## Staging and deployment

This repository demonstrates continuous staging and deployment using Contentful (for CMS) and Google Cloud Storage (for deployment, on both staging and production). To customize the configuration to work with projects owned by you (instead of grow):

1. Replace the Contentful keys with your own Contentful keys.
1. Replace the default project and buckets in `circle.yaml` and `Makefile`.
1. Enable the [Google Cloud Storage JSON API](https://console.developers.google.com/apis/api/storage_api/overview)
1. Create a [Google Cloud service account JSON key](https://console.developers.google.com/apis/credentials)
  1. Download the JSON key you created.
  1. Run `base64 <file> | pbcopy`.
  1. Create a Circle CI environment variable named `CLIENT_SECRET` and paste the encoded key into it.
