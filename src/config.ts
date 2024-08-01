import type { Site, SocialObjects } from "./types";

export const SITE: Site = {
  website: "https://www.tpotts.co.uk", // replace this with your deployed domain
  author: "Thomas Potts",
  profile: "https://github.com/teepeethree",
  desc: "Thomas Potts - Blog",
  title: "Thomas Potts's Blog",
  ogImage: "astropaper-og.jpg",
  lightAndDarkMode: true,
  postPerIndex: 4,
  postPerPage: 5,
  scheduledPostMargin: 15 * 60 * 1000, // 15 minutes
};

export const LOCALE = {
  lang: "en", // html lang code. Set this empty and default will be "en"
  langTag: ["en-EN"], // BCP 47 Language Tags. Set this empty [] to use the environment default
} as const;

export const LOGO_IMAGE = {
  enable: false,
  svg: true,
  width: 216,
  height: 46,
};

export const SOCIALS: SocialObjects = [
  {
    name: "Github",
    href: "https://github.com/teepeethree",
    linkTitle: ` ${SITE.title} on Github`,
    active: true,
  },
  {
    name: "Mail",
    href: "mailto:me@tpotts.co.uk",
    linkTitle: `Send an email to ${SITE.title}`,
    active: true,
  },
];
