import React from 'react';
import { Redirect } from '@docusaurus/router';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';

export default function Home() {
  const {
    siteConfig: { baseUrl },
  } = useDocusaurusContext();

  return <Redirect to={`${baseUrl}docs`} />;
}
