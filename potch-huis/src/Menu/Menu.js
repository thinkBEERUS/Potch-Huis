import './Menu.css';
import Layout from '../Layout/Layout.js';
import { Link } from 'react-router-dom';
import Select from 'react-select';

function Menu() {
  const aquaticCreatures = [
    { label: 'Shark', value: 'Shark' },
    { label: 'Dolphin', value: 'Dolphin' },
    { label: 'Whale', value: 'Whale' },
    { label: 'Octopus', value: 'Octopus' },
    { label: 'Crab', value: 'Crab' },
    { label: 'Lobster', value: 'Lobster' },
  ];
  return (
    <Layout bodyElements={
      <div className='body'>
      <div className='card'>        
        <div className='container'>
          <Select
            options={aquaticCreatures}
            isMulti
            placeholder={'+ Menu Items'}
          />
          <Select
            options={aquaticCreatures}
            isMulti
            placeholder={'- Menu Items'}
          />
        </div>
      </div>
    </div>
    }>
    </Layout>
  );
}

export default Menu;
