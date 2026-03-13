import { Body, Controller, Get, Patch, UseGuards } from '@nestjs/common';
import { ClientDevice } from '@prisma/client';

import { CurrentDevice } from 'src/common/http/decorators/current-device.decorator';
import { DeviceContextGuard } from 'src/common/http/guards/device-context.guard';

import { UpdatePreferencesDto } from './dto/update-preferences.dto';
import { PreferencesService } from './preferences.service';

@UseGuards(DeviceContextGuard)
@Controller('preferences')
/** Handles device-scoped preference reads and updates. */
export class PreferencesController {
  constructor(private readonly preferencesService: PreferencesService) {}

  /** Returns the current device's preference record. */
  @Get()
  getPreferences(@CurrentDevice() device: ClientDevice) {
    return this.preferencesService.getPreferences(device);
  }

  /** Applies a partial preference update for the current device. */
  @Patch()
  updatePreferences(
    @CurrentDevice() device: ClientDevice,
    @Body() body: UpdatePreferencesDto,
  ) {
    return this.preferencesService.updatePreferences(device, body);
  }
}
