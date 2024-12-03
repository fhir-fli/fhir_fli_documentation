import React from 'react';
import Layout from '@theme/Layout';

export default function About() {
  return (
    <Layout title="About">
      <div style={{ padding: '2rem' }}>
        <h1>About FHIR-FLI</h1>
        <p>
          FHIR-FLI (Fast Healthcare Interoperability Resources with Flutter Library Integration)
          FHIR-FLI is an open-source collaborative with the goal of improving healthcare through 
          the use of the FHIR® interoperability standard and the Flutter Toolkit. We believe that 
          lowering the barrier (both technically and monetarily) to entry allows for more innovation, 
          broader applications, and the ability to actually use technology to improve people's lives. 
          Please feel free to join our slack channel, or email me directly grey@fhirfli.dev
        </p>
      </div>
    </Layout>
  );
}
